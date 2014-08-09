[![Build Status](https://travis-ci.org/FlorianGrundig/mtp.svg?branch=master)](https://travis-ci.org/FlorianGrundig/mtp)

Music Training Planner
===

The music training planner helps you to plan your music training.
I'm still not sure about the final feature set, but maybe the motivation shows the path it will be going:  

Motivation
---

I'm learning how to play piano since three years. My former teacher was my grandma who tried to teach me with great 
patience the basic techniques and a lot more. Thereby I have to mention that I learn these techniques not that fast (I'm over 35 years old - 
things are going slower now) but I'm trying hard: If it's possible I train before work (1/2 hour) and before I go to bed (1/2 hour) and on the weekend
I train several hours. What am I training? I'm training the exercises my grandma gave me (each week new exercises depending on my progress).  
  
Now I moved from Berlin to Stockholm and I have no teacher anymore (I will have one - but it will take some time).
So now I don't now what to train because nobody is giving me some exercises. I'll have to give me exercises by myself, 
but that's not that easy as you think.

I know about 25 little music pieces and even more little exercises. I don't want to start really new exercises while 
I don't have a teacher. I'm doing this to prevent me from learning it the wrong way (technique) - 
it's hard to change a learned technique if you got it once...
So I try to get better with the pieces/exercises I already know - there's enough to learn even if you played a piece more than 100 times...
Also I have to repeat all pieces/exercises every e.g. week to not forget them (I thing it's common at my age :).
But I don't have time to repeat everything within one training session. So I have to remember what have I trained last session and the session before and so on - THIS IS (AT LEAST FOR ME) NOT POSSIBLE - 
and that's the problem which should be addressed by the music training planer :)

The music training planer should:

1. be able to 
   1. let me enter my training pieces 
      * with expected training time (e.g. this exercise should take about 5 minutes)
      * with my current (self guessed) progress (e.g. this piece is so easy that I can play it with closed eyes while I'm really drunk)
      * some kind of priority (e.g. to mark pieces which are not worth to train every day because they're long and boring - no new techniques)
      
  2. let me create a plan for the next training session (useful for the time I'll have a teacher again)
      * with as few interaction as possible (the teacher should teach me and not waiting for me updating my plan - that is too expensive)
      
  3. create a adhoc plan depending on my time (e.g. 1/2 hour)
      * it should be done in a intelligent way to maximize my training effects (e.g. the pieces which I'm not good at more often than easy pieces)
      
2. be easy to use
  * I want to have it on my IPad, which I'll put on the piano
  * when I'm training a piece/exercise I want to enter my progress with only a few interactions - the progress should affect the adhoc plan creation I mentioned earlier
  
3. control the time
  * I have only 1/2 hour to train, so he should remind me when it's time to go on with the next exercise - therefor I need something like start session/piece/exercise

I think there thousands of improvements but let's start with this :)

Developement
---

I will document all important steps during the development with git tags and some short notes in the following section.
Please feel free to checkout the interesting step and compare/diff/log it to some other step to see what was done...

Before we start some notes about the desired architecture:
* web app should contain only a small server part which is handling the login/security and mainly redirects requests to the backend layer
* web app should be a single page app
* backend layer should do the business logic part and should be the only one talking to the database
* backend layer should be reached via http requests (JSON)

1. Step-1
  * build the main application via yeoman with the angular-fullstack generator
  * remove all mongoose stuff, because we'll have a backend layer
  * don't think about page design/layout it can look 
  * add travis-ci
  
 
 

