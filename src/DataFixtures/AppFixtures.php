<?php

namespace App\DataFixtures;

use App\Entity\User;
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

        $manager->persist($user);
        $manager->persist($admin);
        
        $manager->flush();
    }
}
