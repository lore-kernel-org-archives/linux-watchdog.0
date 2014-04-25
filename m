Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34040 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077AbaDYOOz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Apr 2014 10:14:55 -0400
Received: by mail-wi0-f170.google.com with SMTP id bs8so2725985wib.1
        for <linux-watchdog@vger.kernel.org>; Fri, 25 Apr 2014 07:14:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9774516974AF5F4C8A2C3C69CD3412333C3B8A95@G4W3297.americas.hpqcorp.net>
References: <1398423149-5028-1-git-send-email-standby24x7@gmail.com>
	<535A5CEE.40008@roeck-us.net>
	<9774516974AF5F4C8A2C3C69CD3412333C3B8A95@G4W3297.americas.hpqcorp.net>
Date: Fri, 25 Apr 2014 23:14:54 +0900
Message-ID: <CALLJCT0NT_1QYxrxRWyE6TXi84Kg1Bbz=x8jc3FLh93i_OBE3g@mail.gmail.com>
Subject: Re: [PATCH] doc: watchdog: Add an usage note on hpwdt with hp-asrd
From: Masanari Iida <standby24x7@gmail.com>
To: "Mingarelli, Thomas" <Thomas.Mingarelli@hp.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

I have encountered a symptom that I could not use hpwdt
with hp-asrd on BL460c Gen8 + RHEL6.4.

How to reproduce
(1)  Start hp-asrd  with ASR timeout as 600 seconds
(2)  Load hpwdt  with soft_margin as 30 seconds.
(3)  # echo 1 > /dev/watchdog  and wait 30 sec to reboot.

Actual Result
No reboot happen.

(4)  Stop hp-asrd
(5)  # echo 1 > /dev/watchdog  and wait 30sec to reboot

Actual Result
Reboot after 30 sec.

And my colleague wrote a small tool to send an ioctl to
/dev/watchdog to get  WDIOC_GETTIMELEFT.

(6)  Run a tool to monitor time left.
(7)  # echo 1 >  /dev/watchdog
(8)  Before 30sec timeout expire, start  hp-asrd .

Result

time left=3D22
time left=3D20
time left=3D19
time left=3D19
time left=3D18
time left=3D17
time left=3D16
time left=3D14
time left=3D13
time left=3D13
time left=3D12
time left=3D599=E3=80=80=E3=80=80<=3D The time when hp-asrd started
time left=3D599
time left=3D599
time left=3D599

So this is the reason why hp-asrd and hpwdt update the same timer.
So I conclude they can not run simultaneously.

Masanari
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
