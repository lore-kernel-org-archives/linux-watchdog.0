Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:17871 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab3FDJh4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Jun 2013 05:37:56 -0400
From: Kukjin Kim <kgene.kim@samsung.com>
To: 'Tomasz Figa' <t.figa@samsung.com>,
	'Sylwester Nawrocki' <sylvester.nawrocki@gmail.com>
Cc: 'Tomasz Figa' <tomasz.figa@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	=?ISO-8859-1?Q?'Heiko_St=FCbner'?= <heiko@sntech.de>,
	'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, jhbird.choi@samsung.com
References: <1368916627-23139-1-git-send-email-tomasz.figa@gmail.com>
 <51A9ADF4.8010102@gmail.com> <1850418.EOBZxN7PB0@amdc1227>
In-reply-to: <1850418.EOBZxN7PB0@amdc1227>
Subject: RE: [PATCH 0/6] Samsung watchdog support clean-up
Date: Tue, 04 Jun 2013 18:37:54 +0900
Message-id: <06d601ce6107$304078c0$90c16a40$%kim@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tomasz Figa wrote:
> 
> Hi Sylwester, Kukjin,
> 
Hi,

> On Saturday 01 of June 2013 10:16:52 Sylwester Nawrocki wrote:
> > Hi Tomasz,
> >
> > On 05/19/2013 12:37 AM, Tomasz Figa wrote:
> > > This series is aiming at cleaning up a bit watchdog support on Samsung
> > > SoCs. The patches tweak a bit all the watchdog handling code here and
> > > there, with the goal of making it DT- and multiplatform-friendly.
> > >
> > > See particular patches for more detailed descriptions.
> > >
> > > On S3C6410-based Tiny6410 board (Mini6410-compatible):
> > >
> > > Tested-by: Tomasz Figa<tomasz.figa@gmail.com>
> >
> > I've tested this series on a s3c2440 based board. The system restart
> > works fine.
> >
> > Tested-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> 
> Thank you Sylwester for testing this series.
> 
Thanks again :-)

> Kukjin, since it has been already tested on s3c24xx and s3c64xx and nobody
> seems to care about s5p64x0 and s5pc100 (although I don't see a reason why
> these patches should break them), could we have this series applied?
> 
OK, let me test this series on the smdk64x0 then, will apply.

If any problems, let you know.

Thanks for your gentle reminder.

- Kukjin

