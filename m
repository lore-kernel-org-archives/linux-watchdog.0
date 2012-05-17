Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41003 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761074Ab2EQOdQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 17 May 2012 10:33:16 -0400
MIME-Version: 1.0
In-Reply-To: <4FB50780.3020904@landley.net>
References: <1337247411-28082-1-git-send-email-devendra.aaru@gmail.com>
	<4FB50780.3020904@landley.net>
Date: Thu, 17 May 2012 20:03:14 +0530
Message-ID: <CAHdPZaMNZDBxTS5utRhNcT-PzL0wOKx8hQGBRc8cPReLTcRP8Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation/watchdog: Fix the file descriptor leak when
 no cmdline arg given
From: "devendra.aaru" <devendra.aaru@gmail.com>
To: Rob Landley <rob@landley.net>
Cc: linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2012 at 7:43 PM, Rob Landley <rob@landley.net> wrote:
> On 05/17/2012 04:36 AM, Devendra Naga wrote:
>> we start a infinite loop when user gives ./watchdog-test, and when use=
r
>> ctrl + c's the program, we just exit immeadiately with out closing the
>> filedescriptor of the watchdog device. a signal handler is used to
>> do the job of closing the filedescriptor and exiting the program.
>
> Doesn't exiting a process close all its filehandles already?

I think kernel will take care of releasing process resources. i am not
so sure of it.
but running valgrind --track-fds=3Dyes ./a.out as root shows a descriptor=
 leak.

BTW, there is another miss, if the user is non-root we still leak a
file descriptor.
>
> Rob
> --
> GNU/Linux isn't: Linux=3DGPLv2, GNU=3DGPLv3+, they can't share code.
> Either it's "mere aggregation", or a license violation. =A0Pick one.

Thanks,
Devendra.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
