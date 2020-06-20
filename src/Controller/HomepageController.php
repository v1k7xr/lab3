<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\Post;

class HomepageController extends AbstractController
{
    /**
     * @Route("/", name="homepage")
     */
    public function index()
    {
        $posts = $this->getDoctrine()
            ->getRepository(Post::class)
            ->findBy([],
            ['addingDate' => 'ASC']
        );

        foreach ($posts as $post) {
            $post->getComments();
        }

        return $this->render('homepage/index.html.twig', [
            'controller_name' => 'HomepageController',
            'posts' => $posts,
        ]);
    }
}
