<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Symfony\Component\Form\Forms;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\Post;
use App\Entity\User;
use App\Entity\Comment;
use App\Form\AddingFormType;
use App\Form\CommentFormType;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;

class UserController extends AbstractController
{
    /**
     * @Route("/deletecmmnt/{idComment}", name="deleteCommentary")
     */
    public function deleteCommentary($idComment)
    {

        if (!$this->get('security.authorization_checker')->isGranted('ROLE_ADMIN')) {
            return $this->redirectToRoute('homepage');
        }

        $entityManager = $this->getDoctrine()->getManager();

        $comment = $entityManager->getRepository(Comment::class)->find($idComment);
        $post = $comment->getPost();
        $entityManager->remove($comment);
        $entityManager->flush();

        return $this->redirectToRoute('post', ['id' => $post->getId()]);
    }

    /** 
    * @Route("/user/commenting") 
    */ 
    public function ajaxAction(Request $request) {
        
        if ($request->isXmlHttpRequest()) {
            
            $entityManager = $this->getDoctrine()->getManager();

            $data = json_decode($request->getContent(), true);

            $user = $entityManager->getRepository(User::class)->find($data['uid']);
            $post = $entityManager->getRepository(Post::class)->find($data['pid']);

            $comment = new Comment();
            $comment->setCommentaryText($data['cmnt']);
            $comment->setCreationDate(new \DateTime());
            $comment->setUsername($user);
            $comment->setPost($post);

            $post->addComment($comment);
            $user->addComment($comment);

            $entityManager->persist($post);
            $entityManager->persist($user);
            $entityManager->persist($comment);
            $entityManager->flush();

            return new JsonResponse([
                'status' => 'ok',
            ]); 
        } else { 
            return new JsonResponse(array(
                'status' => 'Error',
                'message' => 'Error'),
            400); 
        } 
    }  
        
}
