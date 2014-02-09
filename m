Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:63789 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbaBIUOk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 9 Feb 2014 15:14:40 -0500
Message-ID: <52F7E1B0.8020308@roeck-us.net>
Date: Sun, 09 Feb 2014 12:14:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Michal Simek <michal.simek@xilinx.com>,
	linux-kernel@vger.kernel.org, monstr@monstr.eu
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/10] watchdog: xilinx: Fix all printk messages
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com> <fcb21f8907a2025371c612b818a0f2a04a2aa3af.1391177880.git.michal.simek@xilinx.com>
In-Reply-To: <fcb21f8907a2025371c612b818a0f2a04a2aa3af.1391177880.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/31/2014 06:18 AM, Michal Simek wrote:
> Use dev_ functions for printk messages.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


