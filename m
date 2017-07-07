Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33685 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbdGGC0H (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Jul 2017 22:26:07 -0400
MIME-Version: 1.0
In-Reply-To: <CAETC-g_YF7TWv+LNrNQrX9AY_-iepCeE0EmCKWYF4VyQzRY+UQ@mail.gmail.com>
References: <20170621035349.4125-1-zboszor@pr.hu> <20170622132134.7200-1-zboszor@pr.hu>
 <21338590-400b-e1b3-1787-bd275a30c17c@pr.hu> <CAETC-g-0ZYiD=j_sAtYpfr0t-rciiTx3ruvpGuwEud+nbbpiBg@mail.gmail.com>
 <CAETC-g_YF7TWv+LNrNQrX9AY_-iepCeE0EmCKWYF4VyQzRY+UQ@mail.gmail.com>
From: "Marcelo \"Marc\" Ranolfi" <marc.2377@gmail.com>
Date: Thu, 6 Jul 2017 23:26:04 -0300
Message-ID: <CAETC-g-s23nPXYJYRPM4ZRoiP35wjzbzgPMVHPyYwrGYCBPdBg@mail.gmail.com>
Subject: Re: [PATCH 0/5 v4] Fix sp5100_tco watchdog driver regression
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

(Reposting without html subpart, second attempt)

On Thu, Jul 6, 2017 at 11:09 PM, Marcelo "Marc" Ranolfi
<marc.2377@gmail.com> wrote:
Hi Zolt=C3=A1n and all,

I _was_ testing the patch series (the latest version), system worked
OK for two days, but then I got a system crash (probably hardware
related) and lost my files in the main partition. Posted about it in
the F2FS mailing list
(https://sourceforge.net/p/linux-f2fs/mailman/message/35928135/).

While I don't believe that the freeze/crash was caused by the watchdog
driver (many other things to blame: amdgpu driver on Southern Islands,
CPU voltage lower than recommended...), it's worth mentioning that the
computer was completely frozen for a little over 4 minutes, and did
not reset as I'd expect the watchdog to. Just mentioning because I'm
not sure of the implications.

Once I get my system back online this weekend I'll have a good look at
the code. Anyway, thanks again for the patches and I'm also expecting
someone more qualified (than me, at least) to review them.

Regards
Marcelo "Marc" Ranolfi
