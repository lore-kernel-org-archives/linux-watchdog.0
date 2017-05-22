Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:50060 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760140AbdEVS5b (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 22 May 2017 14:57:31 -0400
Date: Mon, 22 May 2017 19:07:51 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: <linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        <esben.haabendal@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 0/3] watchdog: allow setting deadline for opening
 /dev/watchdogN
Message-ID: <20170522190751.5bf5e813@alans-desktop>
In-Reply-To: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 22 May 2017 16:06:36 +0200
Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:

> If a watchdog driver tells the framework that the device is running,
> the framework takes care of feeding the watchdog until userspace opens
> the device. If the userspace application which is supposed to do that
> never comes up properly, the watchdog is fed indefinitely by the
> kernel. This can be especially problematic for embedded devices.
> 
> These patches allow one to set a maximum time for which the kernel
> will feed the watchdog, thus ensuring that either userspace has come
> up, or the board gets reset. This allows fallback logic in the
> bootloader to attempt some recovery (for example, if an automatic
> update is in progress, it could roll back to the previous version).


This makes sense except for being a CONFIG_ option not a boot parameter.
If it's a boot parameter then the same kernel works for multiple systems
and is general. If it's compile time then you have to build a custom
kernel.

For some embedded stuff that might not matter (although I bet they'd
prefer it command line/device tree too) but for something like an x86
platform where you are deploying a standard vendor supplied kernel it's
bad to do it that way IMHO.

In other words I think you should drop patch 3 but the rest is good.

Alan
