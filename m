Return-path: <j.uzycki@elproma.com.pl>
Message-ID: <541C3329.3010409@elproma.com.pl>
Date: Fri, 19 Sep 2014 15:44:09 +0200
From: =?windows-1250?Q?Janusz_U=BFycki?= <j.uzycki@elproma.com.pl>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 Wim Van Sebroeck <wim@iguana.be>,
 linux-kernel@vger.kernel.org
Subject: Re: timers vs drivers suspend race
References: <541BFB63.3060006@elproma.com.pl> <541C122D.10305@elproma.com.pl>
In-Reply-To: <541C122D.10305@elproma.com.pl>
Content-Type: multipart/alternative;
 boundary="------------090509010208000501080801"
List-ID: <linux-watchdog@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090509010208000501080801
Content-Type: text/plain; charset=windows-1250; format=flowed
Content-Transfer-Encoding: 8bit


W dniu 2014-09-19 13:23, Janusz U¿ycki pisze:
> Hi.
>
> I have a doubt about suspending of timers.
> I found the patch (not included to linux-next):
> https://lkml.org/lkml/2014/7/21/493
> but it concerns timers only.
>
> I'm adding PM to the watchdog driver (below).
> The driver is capable to stop the watchdog.
> However I implemented "keep-on" feature to ping
> active watchdog if userland doesn't do it.
> For the feature I used a timer.
> Now, on wdt_suspend() call I don't know
> if timers are suspended before the watchdog driver or
> there is no guarantee (race): wdt_suspend() calls wdt_stop()
> and after timer's callback will ping watchdog and reenable it.
>
> I found also:
> https://lkml.org/lkml/2007/10/25/9
> Here del_timer_sync() is called and it solves
> the problem.
> In my case the timer is serviced in watchdog_dev,
> not in the specific-driver.
> I can add a flag in the specific-driver
> to block watchdog's ping before wdt_stop()
> or export new function to suspend/resume
> watchdog_dev's timer from the specific-driver.
>
> Could you advice is it necessary?

Does changing SIMPLE_DEV_PM_OPS to SET_LATE_SYSTEM_SLEEP_PM_OPS
solve the race problem with timer?

best regards
Janusz



--------------090509010208000501080801
Content-Type: text/html; charset=windows-1250
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1250"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <div class="moz-cite-prefix">W dniu 2014-09-19 13:23, Janusz U¿ycki
      pisze:<br>
    </div>
    <blockquote cite="mid:541C122D.10305@elproma.com.pl" type="cite">
      <meta http-equiv="content-type" content="text/html;
        charset=windows-1250">
      Hi.<br>
      <br>
      I have a doubt about suspending of timers.<br>
      I found the patch (not included to linux-next):<br>
      <a moz-do-not-send="true" class="moz-txt-link-freetext"
        href="https://lkml.org/lkml/2014/7/21/493">https://lkml.org/lkml/2014/7/21/493</a><br>
      but it concerns timers only.<br>
      <br>
      I'm adding PM to the watchdog driver (below).<br>
      The driver is capable to stop the watchdog.<br>
      However I implemented "keep-on" feature to ping<br>
      active watchdog if userland doesn't do it.<br>
      For the feature I used a timer.<br>
      Now, on wdt_suspend() call I don't know<br>
      if timers are suspended before the watchdog driver or<br>
      there is no guarantee (race): wdt_suspend() calls wdt_stop()<br>
      and after timer's callback will ping watchdog and reenable it.<br>
      <br>
      I found also:<br>
      <a moz-do-not-send="true" class="moz-txt-link-freetext"
        href="https://lkml.org/lkml/2007/10/25/9">https://lkml.org/lkml/2007/10/25/9</a><br>
      Here del_timer_sync() is called and it solves<br>
      the problem.<br>
      In my case the timer is serviced in watchdog_dev,<br>
      not in the specific-driver.<br>
      I can add a flag in the specific-driver<br>
      to block watchdog's ping before wdt_stop()<br>
      or export new function to suspend/resume<br>
      watchdog_dev's timer from the specific-driver.<br>
      <br>
      Could you advice is it necessary?<br>
    </blockquote>
    <br>
    Does changing SIMPLE_DEV_PM_OPS to SET_LATE_SYSTEM_SLEEP_PM_OPS<br>
    solve the race problem with timer?<br>
    <br>
    best regards<br>
    Janusz<br>
    <br>
    <br>
  </body>
</html>

--------------090509010208000501080801--
