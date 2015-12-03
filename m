Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56416 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbbLCR7Q (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Dec 2015 12:59:16 -0500
Date: Thu, 3 Dec 2015 09:59:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>
Subject: Re: Need for ref/unref functions in watchdog drivers
Message-ID: <20151203175913.GA19134@roeck-us.net>
References: <565C80A2.6020505@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565C80A2.6020505@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Nov 30, 2015 at 09:00:18AM -0800, Guenter Roeck wrote:
> Hi,
> 
> I keep being puzzled about the ref/unref functions for watchdog drivers.
> 
> Hardly any driver implements those functions, even though many allocate
> the watchdog_device data structure dynamically. At the same time, I don't
> recall ever seeing a crash or traceback because of it.
> 
> Granted, many watchdogs are only loaded and never unloaded, but one
> should think that the problem is seen at least once in a while.
> 
> Does anyone know how to trigger the problem which makes the ref/unref
> functions necessary ? I would like to reproduce it and then try to find a better
> solution, ie one that doesn't need those functions in the drivers (seems to me
> the infrastructure should ensure that a driver isn't unloaded while in use).
> 
Ok, for the record, answering my own question.

The lifetime of (dynamically allocated) struct watchdog_device differs from
the lifetime of objects from struct watchdog_device used by the watchdog core.
This applies to status bits, the lock, and cdev. The watchdog core needs to
access those objects even after a watchdog device was unregistered if
/dev/watchdogX was open at the time of unregistration.

Unless a dynamically allocated struct watchdog_device is prevented from being
released by a watchdog driver, this will result in a crash when an access
to the watchdog (and thus to struct watchdog_device) through watchdog file
operations is made after the device was unregistered.

This is somewhat difficult to reproduce, since instantiation of watchdog drivers
tends to be static either through platform device registration or with devicetree
properties. I was able to reproduce it by instantiating a watchdog through a
devicetree overlay; the crash happens after the overlay is unloaded.

Unfortunately, two out of three drivers implementing ref/unref callbacks do
it wrong. While implementing those callbacks, they still release the memory
associated with struct watchdog_device on device removal. Most of the drivers
which dynamically allocate struct watchdog_device don't implement ref/unref
to start with. Not surprising, as it is a bit difficult to understand.

Clean fix will be to separate objects in struct watchdog_device based on object
lifetime, to allocate the objects needed by the watchdog core locally, and to
handle reference counting for those objects from within the watchdog core.
I have working prototype code doing just that.

Guenter
