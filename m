Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:65120 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab3LKW5q (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 Dec 2013 17:57:46 -0500
Received: by mail-vc0-f180.google.com with SMTP id if17so6235849vcb.11
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Dec 2013 14:57:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAL1wa8fTuOMk9=G3JhdpNOE8=FPTfMSJ_mB-7jo1pNF1cAavgg@mail.gmail.com>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com>
	<1386308868-30264-2-git-send-email-l.krishna@samsung.com>
	<52A207D8.3030206@gmail.com>
	<8302228.6iSJIFqj3A@flatron>
	<52A39F3B.5070806@gmail.com>
	<CAL1wa8fTuOMk9=G3JhdpNOE8=FPTfMSJ_mB-7jo1pNF1cAavgg@mail.gmail.com>
Date: Wed, 11 Dec 2013 14:57:45 -0800
Message-ID: <CAD=FV=WZNmWdxTWzHCEtkCo7O1RZ7YDNkmNBD4wwpDc-=O1LCQ@mail.gmail.com>
Subject: Re: [PATCH V12 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
From: Doug Anderson <dianders@chromium.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"cpgs ." <cpgs@samsung.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Leela Krishna,

On Wed, Dec 11, 2013 at 4:22 AM, Leela Krishna Amudala
<l.krishna@samsung.com> wrote:
> Hi,
>
> As I was in travel not accessed my mails.
>
> I'll try to post next version of this series tomorrow addressing
> Sylwester's comments.

It's completely up to you (and Wim), of course.  ...but if it were me
I wouldn't spin the patch at this point.  Your existing version has
Guenter's Ack and his indication that he thinks that v12 is good
enough to land without future spins.  You could spin with Tomasz /
Sylwester's suggestions but remember that it is not mandatory.

-Doug
