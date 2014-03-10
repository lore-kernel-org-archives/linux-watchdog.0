Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:60998 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbaCJCaq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 9 Mar 2014 22:30:46 -0400
Message-ID: <531D23D3.50505@roeck-us.net>
Date: Sun, 09 Mar 2014 19:30:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH v2 3/7] watchdog: orion: Introduce per-SoC enabled() function
References: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com> <1393949244-5011-4-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1393949244-5011-4-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/04/2014 08:07 AM, Ezequiel Garcia wrote:
> In order to support other SoCs, it's needed to have a different enabled()
> implementation for each SoC. This commit adds no functionality, and it
> consists of preparation work.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

