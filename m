Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:41976 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbaJVN4L (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Oct 2014 09:56:11 -0400
Date: Wed, 22 Oct 2014 15:55:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-watchdog@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] Make Armada 375 use the reference clock when possible
Message-ID: <20141022135518.GO9845@lunn.ch>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 22, 2014 at 10:34:40AM -0300, Ezequiel Garcia wrote:
> This series adds support for the 25 MHz reference clock available on
> Armada 375 SoC to use on the timer and watchdog drivers. It is
> similar to the one present in Armada XP SoC.
> 
> Given we initially had access to only a very early SoC revision (A375 Z0)
> and due to a hardware issue, the timer and watchdog support was originally
> submitted to use the core clock.

Hi Ezequiel

What happens with Z0 when used with these patches? Do they continue to
work? Do these hardware issues cause a problem?

> Now that the A0 SoC revision is out, we can fix this and use the reference
> clock. The reason for this change is that the core clock is subject to the
> SSCG, so boards where SSCG is enabled exhibit a very large timer drift.

It would of been nice to say what SSCG is. I had to go look it up.
However, since this is just in the cover note and not in the patches
itself, it is not important.

	Andrew
