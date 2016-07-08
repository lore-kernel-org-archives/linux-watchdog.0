Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34850 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbcGHNXu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Jul 2016 09:23:50 -0400
Subject: Re: I/O address 0x0cd6 already in use
To: ioanm@linux.com, linux-watchdog@vger.kernel.org
References: <CAH2idReJfXsd3QWvpRKnaLpw_isURt2p81VdGpPEU9dPnPHQpA@mail.gmail.com>
 <577E71D0.3030207@roeck-us.net>
 <CAH2idRciNOYZ9x8HC6oJM77pfJ2V93eamSxxpGMe_gtQOoyi2Q@mail.gmail.com>
 <20160707191600.GA9431@roeck-us.net>
 <CAH2idRff1LPQmLiA60HbQkE27CMUPan0N3wHoSCvAsfZoCvHww@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <577FA963.70408@roeck-us.net>
Date: Fri, 8 Jul 2016 06:23:47 -0700
MIME-Version: 1.0
In-Reply-To: <CAH2idRff1LPQmLiA60HbQkE27CMUPan0N3wHoSCvAsfZoCvHww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/07/2016 09:59 PM, Ioan Moldovan wrote:
> Okay, but won't unloading i2c cause errors?

Not loading the i2c controller would mean that you can not access
any of the i2c devices connected to the i2c bus.

> Or won't unloading watchdog and keeping just i2c also cause errors?

Unloading (or, rather, not loading) the watchdog driver means that
you won't be able to use the watchdog.

Sure, both is undesirable, but unless we hear otherwise we have to assume
that the change to the i2c driver was made on purpose, and there isn't
really anything we can do about it.

Guenter

