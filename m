Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:53726 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190AbaCOVZQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Mar 2014 17:25:16 -0400
Message-ID: <5324C535.6010009@roeck-us.net>
Date: Sat, 15 Mar 2014 14:25:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
CC: Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH v4 1/9] watchdog: orion: Move the register ioremap'ing
 to its own function
References: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com> <1394907484-26002-2-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1394907484-26002-2-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/15/2014 11:17 AM, Ezequiel Garcia wrote:
> Follow-up patches will extend the registers ioremap and request
> to handle SoC-specific quirks on the RSTOUT register. Therefore,
> in order to keep the code readable, this commit introduces a special
> function for this.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


