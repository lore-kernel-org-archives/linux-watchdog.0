Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:51663 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbbJ1RCU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Oct 2015 13:02:20 -0400
Date: Wed, 28 Oct 2015 12:52:51 -0400
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Dinh Nguyen <dinh.linux@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	shawnguo@kernel.org, Sascha Hauer <kernel@pengutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>, kernel@savoirfairelinux.com
Subject: Re: [PATCH 2/4] watchdog: ts4800: add new driver for TS-4800 watchdog
Message-ID: <20151028165251.GA5948@localhost>
References: <1445978021-13961-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1445978021-13961-3-git-send-email-damien.riegel@savoirfairelinux.com>
 <CADhT+wdWcYMQ_ZPhcGOye3oP=6N+Yos+sbqV20E5x5Hmfm8ycw@mail.gmail.com>
 <20151027215135.GA4676@localhost>
 <20151028020501.GA1548@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151028020501.GA1548@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Oct 27, 2015 at 07:05:01PM -0700, Guenter Roeck wrote:
> In general, naming a driver for the first chip it supports is not
> problematic. Making it too generic is, on the other side, problematic.
> What are you going to do if ts4900 (or ts4801) implements a different
> watchdog ?

Okay, I will keep the current name.

I noticed that other boards might have their feed register at different
offsets from syscon base. For instance, feed register is at offset 0x6
on TS-4720 and offset 0xE on TS-4800 (syscon registers are 16-bit wide).
So I need to address that as well (it is related to the next point).

Currently, the driver maps all syscon registers even if it uses only one
of them. I was thinking about adding a "syscon" node and define the
watchdog as a child of it, but the syscon driver set
syscon_regmap_config.val_bits to 32. Do I have to create a new driver if
I want to use val_bits = 16, or is there another way ?

Damien
