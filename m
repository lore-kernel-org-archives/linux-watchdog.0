Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51505 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbaKEJ61 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Nov 2014 04:58:27 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: at91: rm9200 add system timer resources to watchdog
Date: Wed, 05 Nov 2014 10:58:22 +0100
Message-ID: <7422028.lkBOqUd5nl@wuerfel>
In-Reply-To: <20141104224126.GD22928@piout.net>
References: <1414788359-15759-1-git-send-email-alexandre.belloni@free-electrons.com> <3833756.aJxOhkuG91@wuerfel> <20141104224126.GD22928@piout.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 04 November 2014 23:41:26 Alexandre Belloni wrote:
> On 31/10/2014 at 22:36:55 +0100, Arnd Bergmann wrote :
> > On Friday 31 October 2014 21:57:56 Alexandre Belloni wrote:
> > > On 31/10/2014 at 21:50:05 +0100, Arnd Bergmann wrote :
> > > > On Friday 31 October 2014 21:45:58 Alexandre Belloni wrote:
> > > > > To be able to make the watchdog driver independent from the mach/ includes, pass
> > > > > the system timer register space as a resource.
> > > > > 
> > > > > Also, change the name to avoid conflicting with the at91sam9 watchdog driver.
> > > > > 
> > > > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > > > 
> > > > 
> > > > Doing this change as a separate patch breaks bisection because now the device
> > > > name no longer matches untile the other patch is applied too.
> > > > 
> > > 
> > > Yeah, I was not sure how important that was as there is no user of the
> > > watchdog in the kernel. My thinking was that both patch can then go
> > > through different trees.
> > > 
> > > I can definitely squash them.
> > 
> > AFAICT, arch/arm/configs/at91rm9200_defconfig enables the device and it
> > gets registered through at91_add_standard_devices. You definitely have
> > my Ack to merge the mach-at91 patch through the watchdog tree.
> > 
> 
> You're right, I missed that one. I was expecting it to be called from
> board files.
> 
> So, I'll squash both patches, add your SoB and your Ack and get it
> merged through the watchdog tree, tell me if that is not what you
> expect.

I definitely *don't* expect you to add my Signed-off-by, that would
be against the procedures we have in Documentation/SubmittingPatches.

Other than that, it sounds good, thanks!

	Arnd
