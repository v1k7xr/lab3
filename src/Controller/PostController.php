<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Symfony\Component\Form\Forms;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\Post;
use App\Entity\Comment;
use App\Form\AddingFormType;
use App\Form\CommentFormType;
use Symfony\Component\HttpFoundation\Request;


class PostController extends AbstractController
{
    /**
     * @Route("/post/{id}", name="post")
     */
    public function index(Request $request, $id)
    {

        $entityManager = $this->getDoctrine()->getManager();

        $post = $entityManager->getRepository(Post::class)->find($id);

        if (!$this->get('security.authorization_checker')->isGranted('ROLE_ADMIN')) {
            $post->setViewsCount($post->getViewsCount() + 1);
            $entityManager->flush();
        }
        
        if(!$post) {
            throw $this->createNotFoundException('Данного поста нет');
        }

        $comments = $post->getComments();

        $comment = new Comment();
        $comment->setPost($post);
        $comment->setUsername($this->getUser());


        $form = $this->createForm(AddingFormType::class, $post)->handleRequest($request);

        return $this->render('post/index.html.twig', [
            'controller_name' => 'PostController',
            'post' => $post,
            'comments' => $comments,
            //'comment' => $form->createView()
        ]);
    }

    /**
     * @Route("/addpost", name="addPost")
     */
    public function addPost(Request $request)
    {
        if (!$this->get('security.authorization_checker')->isGranted('ROLE_ADMIN')) {
            return $this->redirectToRoute('homepage');
        }

        $post = new Post();

        $form = $this->createForm(AddingFormType::class, $post)->handleRequest($request);

        if($form->isSubmitted() && $form->isValid()) {
            
            $entityManager = $this->getDoctrine()->getManager();
            $post->setAddingDate(new \DateTime());
            $post->setViewsCount(0);

            $entityManager->persist($post);

            $entityManager->flush();

            return $this->redirectToRoute('homepage');
        }

        return $this->render('post/adding.html.twig', [
            'post' => $form->createView()
        ]);
    }

    /**
     * @Route("/delete/{id}", name="deletePost")
     */
    public function deletePost($id)
    {
        if (!$this->get('security.authorization_checker')->isGranted('ROLE_ADMIN')) {
            return $this->redirectToRoute('homepage');
        }

        $entityManager = $this->getDoctrine()->getManager();

        $post = $entityManager->getRepository(Post::class)->find($id);


        if(!$post) {
            throw $this->createNotFoundException('Данного поста нет');
        }

        $comments = $post->getComments();

        foreach ($comments as $comment) {
            $entityManager->remove($comment);
        }

        $entityManager->remove($post);
        $entityManager->flush();

        return $this->redirectToRoute('homepage');
    }

    /**
    * @Route("/change/{id}", name="changePost")
    */
    public function changePost(Request $request, $id) {

        $securityContext = $this->container->get('security.authorization_checker');
        if (!$securityContext->isGranted('IS_AUTHENTICATED_REMEMBERED')) {
            return $this->redirectToRoute('mainpage');
        }

        $request = $this->get('request_stack')->getCurrentRequest();
        

        $entityManager = $this->getDoctrine()->getManager();
        $post = $entityManager->getRepository(Post::class)->find($id);

        $form = $this->createForm(AddingFormType::class, $post);
        $form->handleRequest($request);

        if ($form->isSubmitted()) {

            // perform some action, such as save the object to the database
            $entityManager->flush();

            return $this->redirectToRoute('homepage');
        }

        return $this->render('post/change.html.twig', [
            'post' => $post,
            'changePost' => $form->createView(),
        ]);
        
    }
    
}
