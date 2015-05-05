Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:54954 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161183AbbEEJke (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 5 May 2015 05:40:34 -0400
Date: Tue, 5 May 2015 11:40:31 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: harald@ccbib.org
Cc: rtc-linux@googlegroups.com, Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20150505094031.GH4276@piout.net>
References: <1428522355-5164-1-git-send-email-harald@ccbib.org>
 <20150417093023.GF29796@piout.net>
 <3a787a0b2777c4b734a4f153e1a3f7d7@imap.cosmopool.net>
 <20150419153743.GA4353@piout.net>
 <480bd3b38b87b44913868cbd2f3e24c6@imap.cosmopool.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480bd3b38b87b44913868cbd2f3e24c6@imap.cosmopool.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 20/04/2015 at 09:11:02 +0200, harald@ccbib.org wrote :
> Hi Alexandre,
> 
> On Sun, 19 Apr 2015 17:37:43 +0200, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > On 19/04/2015 at 15:41:42 +0200, harald@ccbib.org wrote :
> >> >  - use syscon instead of passing callbacks to the watchdog driver
> >> 
> >> I will put looking into this onto my todo list, but I'm not familiar
> >> with syscon yet and it is not obvious to me how to port the rtc driver
> >> to syscon without breaking devicetree backwards compatibility. So I'd
> >> like to defer this for later unless somebody gives me some guidance.
> >> 
> > 
> > As the rtc driver is the one instantiating the watchdog driver, there is
> > no reason why the DT ABI would be broken. You simply have to create
> > the syscon in the RTC driver and then pass it to the watchdog driver,
> > the same way it is done with the callbacks.
> 
> Ok, this is less invasive than what I have been thinking. This makes
> sense. 
>  

I realized I confused syscon with regmap. So indeed, switching to syscon
will require a not nice change to the DT. But what I really meant was
creating a regmap from the rtc driver and pass it to the watchdog
driver.

> > I can have a look at doing it as I have some i.mx28 platforms.
> 
> If you can point me to a driver that is a good reference for your model,
> then I can do this myself. Otherwise I'd prefer if you wrote the code.
> I can do the testing though, if this helps.
> 

You can have a look at the devm_regmap_init_mmio() users.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
