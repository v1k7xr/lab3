<?php

namespace App\DataFixtures;

use App\Entity\User;
use App\Entity\Post;
use App\Entity\Comment;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Common\Persistence\ObjectManager;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class AppFixtures extends Fixture
{

    private $passwordEncoder;

    public function __construct(UserPasswordEncoderInterface $encoder) {
        $this->passwordEncoder = $encoder;
    }

    public function load(ObjectManager $manager)
    {
        // $product = new Product();
        // $manager->persist($product);
        
        $user = new User();
        $user->setEmail('user@mail.com');
        $user->setPassword($this->passwordEncoder->encodePassword($user, 'User123!'));
        $user->setRoles(['ROLE_USER']);
        $user->setNickname('User01');

        $admin = new User();
        $admin->setEmail('admin@mail.com');
        $admin->setPassword($this->passwordEncoder->encodePassword($user, '4dmin123!'));
        $admin->setRoles(['ROLE_ADMIN']);
        $admin->setNickname('Admin01');
        
        $post = new Post();
        $post->setName('test post');
        $date = \DateTime::createFromFormat('Y-m-d', "2020-06-19");
        $post->setAddingDate($date);
        $post->setDescription('description for test post');
        $post->setFullText('text of test post');
        $post->setViewsCount(0);

        $comment = new Comment();
        $comment->setCommentaryText('test comment');
        $comment->setPost($post);
        $comment->setCreationDate($date);
        $comment->setUsername($user);


        $manager->persist($user);
        $manager->persist($admin);
        $manager->persist($post);
        $manager->persist($comment);

        $manager->flush();
    }
}
