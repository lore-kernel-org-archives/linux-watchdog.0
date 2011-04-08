Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37218 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756221Ab1DHMZx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 8 Apr 2011 08:25:53 -0400
Date: Fri, 8 Apr 2011 13:25:41 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <guenter.roeck@ericsson.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] Make all it87 drivers SMP safe.
Message-ID: <20110408132541.39042e95@lxorguk.ukuu.org.uk>
In-Reply-To: <1302038697-28985-1-git-send-email-natg@google.com>
References: <1302038697-28985-1-git-send-email-natg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> attempts to serialize access to the hardware by defining a global spinlock
> it87_io_lock in a file it87_lock.c. This lock has to be acquired by each
> of the it87 drivers before it can access the hardware. We have defined

I think this needs a NAK

The resource handler can do this for you and would ensure proper
behaviour.

See
	IORESOURCE_MUXED


Providing the it87 drivers request the resources (which they need to do
anyway!) and use IORESOURCE_MUXED, it should all work ?

Alan
