Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50621 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755886AbcH2XxD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 29 Aug 2016 19:53:03 -0400
Date: Mon, 29 Aug 2016 16:53:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Nicolas Boullis <nboullis@debian.org>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: Linux-compatible watchdog add-on?
Message-ID: <20160829235301.GA2073@roeck-us.net>
References: <20160825163149.GB3636@haddock.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160825163149.GB3636@haddock.home>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 25, 2016 at 06:31:49PM +0200, Nicolas Boullis wrote:
> Hi,
> 
> Sorry if my question is off-topic for this list.
> 
> I have a computer that experienced a kernel failure while a was far away 
> and nobody could reboot it. So I thought it would be nice to have a 
> watchdog. Unfortunately, to the best of my knowledge, it has no hardware 
> watchdog, so I thought I should add one.
> 
> Hence, do you have suggestions for I²C-, serial- or USB-connected 
> watchdog add-ons? It should of course be compatible with linux.
> 
> I found 
>   http://www.berkprod.com/Product_Web_Pages/usb_v1_pc_watchdog.aspx
> but I think it is a little too expensive.
> 
> If no such thing exists, I might consider designing my own (open 
> hardware) I²C- or USB-connected watchdog add-on, using a cheap MCU. But 
> then I would welcome opinions on what the interface between the host and 
> watchdog should look like.
> 
Anything you come up with will need a connection to the system reset,
so you'll have to have an in-chassis solution. Any cheap MCU with USB
or I2C port and a couple of GPIO ports would probably do.

If you consider the above product, make sure that you get an assurance
that its Linux driver still works - it is quite old.

Guenter
