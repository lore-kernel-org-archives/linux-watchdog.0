Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:49043 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbaA2UQH (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jan 2014 15:16:07 -0500
Date: Wed, 29 Jan 2014 21:15:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 16/20] ARM: kirkwood: Add RSTOUT 'reg' entry to
 devicetree
Message-ID: <20140129201554.GJ10864@lunn.ch>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390836440-12744-17-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390836440-12744-17-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 27, 2014 at 12:27:16PM -0300, Ezequiel Garcia wrote:
> In order to support multiplatform builds the watchdog devicetree binding
> was modified and now the 'reg' property is specified to need two
> entries. This commit adds the second entry as-per the new specification.
> 
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Hi Ezequiel

I tested on Kirkwood, using the standard watchdog test cases. Works
great.

Tested-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew
