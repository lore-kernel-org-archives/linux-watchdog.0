Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22334 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab3FJKA7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Jun 2013 06:00:59 -0400
From: Kukjin Kim <kgene.kim@samsung.com>
To: 'Tomasz Figa' <t.figa@samsung.com>
Cc: 'Sylwester Nawrocki' <sylvester.nawrocki@gmail.com>,
	'Tomasz Figa' <tomasz.figa@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	=?ISO-8859-1?Q?'Heiko_St=FCbner'?= <heiko@sntech.de>,
	'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, jhbird.choi@samsung.com
References: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
 <1850418.EOBZxN7PB0@amdc1227>
 <06d601ce6107$304078c0$90c16a40$%kim@samsung.com> <1449207.t4YSBOKy4W@amdc1227>
In-reply-to: <1449207.t4YSBOKy4W@amdc1227>
Subject: RE: [PATCH 0/6] Samsung watchdog support clean-up
Date: Mon, 10 Jun 2013 19:00:57 +0900
Message-id: <0ee601ce65c1$673f2c90$35bd85b0$%kim@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tomasz Figa wrote:
> 
> Hi Kukjin,
> 
> On Tuesday 04 of June 2013 18:37:54 Kukjin Kim wrote:
> > Tomasz Figa wrote:
> > > Hi Sylwester, Kukjin,
> >
> > Hi,
> >
> > > On Saturday 01 of June 2013 10:16:52 Sylwester Nawrocki wrote:
> > > > Hi Tomasz,
> > > >
> > > > On 05/19/2013 12:37 AM, Tomasz Figa wrote:
> > > > > This series is aiming at cleaning up a bit watchdog support on Samsung
> > > > > SoCs. The patches tweak a bit all the watchdog handling code here and
> > > > > there, with the goal of making it DT- and multiplatform-friendly.
> > > > >
> > > > > See particular patches for more detailed descriptions.
> > > > >
> > > > > On S3C6410-based Tiny6410 board (Mini6410-compatible):
> > > > >
> > > > > Tested-by: Tomasz Figa<tomasz.figa@gmail.com>
> > > >
> > > > I've tested this series on a s3c2440 based board. The system restart
> > > > works fine.
> > > >
> > > > Tested-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> > >
> > > Thank you Sylwester for testing this series.
> >
> > Thanks again :-)
> >
> > > Kukjin, since it has been already tested on s3c24xx and s3c64xx and nobody
> > > seems to care about s5p64x0 and s5pc100 (although I don't see a reason why
> > > these patches should break them), could we have this series applied?
> >
> > OK, let me test this series on the smdk64x0 then, will apply.
> >
> > If any problems, let you know.
> >
> > Thanks for your gentle reminder.
> 
> Thank you for handling this. I have a lot of patches for S3C64xx depending on
> this series queued in my private tree and it would be really nice if I could
> finally get them merged for 3.11.
> 
Applied, thanks.

- Kukjin

