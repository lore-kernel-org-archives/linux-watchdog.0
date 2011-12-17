Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57166 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1LQWub convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 17 Dec 2011 17:50:31 -0500
MIME-Version: 1.0
In-Reply-To: <CACRpkdbcLYoVEN6HJjw=Wq=5e77LJjnSQmwMD4K+UM4h+jDhBg@mail.gmail.com>
References: <CAK3+h2zaZ3J4F4_rx6LGM0f_iY7ao8rU9nCt3EpZXDRGrqm3hQ@mail.gmail.com>
	<CACRpkdbcLYoVEN6HJjw=Wq=5e77LJjnSQmwMD4K+UM4h+jDhBg@mail.gmail.com>
Date: Sat, 17 Dec 2011 14:50:29 -0800
Message-ID: <CAK3+h2zexM0J=f4Ten33RWs2W0V64itY9XFdc1HqA=tk0CaM+w@mail.gmail.com>
Subject: Re: Seeking Linux watchdog design advice to trouble shoot mystory
 silent reboot issue
From: Vincent Li <vincent.mc.li@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2011 at 2:11 PM, Linus Walleij <linus.walleij@linaro.org>=
 wrote:
> On Mon, Dec 5, 2011 at 8:55 PM, Vincent Li <vincent.mc.li@gmail.com> wr=
ote:
>
>> we have =A0a complex system with a large number of processes running
>> simutanously. If any of the processes gets into a faulty state and
>> hangs or consumes more than its fair share of the system resources,
>> the other processes may not get a chance to run, and the whole system
>> can hang, interrupting the system functionality and user traffic.
>
> Have you tried using RLIMITs?
>
> Last time I used something like this from each process:
>
> #include <sys/time.h>
> #include <sys/resource.h>
>
> struct rlimit rl;
> int ret;
>
> // No process run more than 5 seconds
> rl.rlim_cur =3D rl.rlim_max =3D 5;
> ret =3D setrlimit(RLIMIT_CPU, &rl);
> // No realtime process run more than 1 second
> rl.rlim_cur =3D rl.rlim_max =3D 1000000;
> ret =3D setrlimit(RLIMIT_RTTIME, &rl);
>
> The latter is good if you have real-time processes.
>
> There are also RLIMITs for memory consumption.
>
> Consult:
> http://kernel.org/doc/man-pages/online/pages/man2/getrlimit.2.html
>

thank you for the link, I will look into it.

Vincent
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
