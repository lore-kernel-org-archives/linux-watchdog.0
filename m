Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:52913 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbaBJAvg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 9 Feb 2014 19:51:36 -0500
Message-ID: <52F82296.8010804@roeck-us.net>
Date: Sun, 09 Feb 2014 16:51:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Michal Simek <michal.simek@xilinx.com>,
	linux-kernel@vger.kernel.org, monstr@monstr.eu
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 10/10] watchdog: xilinx: Enable this driver for Zynq
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com> <f7bdfada576e93eaab8f6dc2ecd881da8f43911c.1391177880.git.michal.simek@xilinx.com>
In-Reply-To: <f7bdfada576e93eaab8f6dc2ecd881da8f43911c.1391177880.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/31/2014 06:18 AM, Michal Simek wrote:
> Enable this driver for Zynq.
> Move it to architecture independent Kconfig part.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Build tested by zero day testing system.
> ---

Hi Michal,

I tried myself, and I don't see any build failures on any platform.
So let's assume this works as-is.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

