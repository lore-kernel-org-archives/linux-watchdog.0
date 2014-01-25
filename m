Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:60293 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbaAYSNg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 Jan 2014 13:13:36 -0500
Message-ID: <52E3FED0.6040003@roeck-us.net>
Date: Sat, 25 Jan 2014 10:13:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 06/18] watchdog: orion: Make sure the watchdog is initially
 stopped
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390431915-5115-7-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390431915-5115-7-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/22/2014 03:05 PM, Ezequiel Garcia wrote:
> Having the watchdog initially fully stopped is important to avoid
> any spurious watchdog triggers, in case the registers are not in
> its reset state.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


