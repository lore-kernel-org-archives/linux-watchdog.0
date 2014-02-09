Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:57750 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbaBIUNB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 9 Feb 2014 15:13:01 -0500
Message-ID: <52F7E14D.8060607@roeck-us.net>
Date: Sun, 09 Feb 2014 12:13:01 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Michal Simek <michal.simek@xilinx.com>,
	linux-kernel@vger.kernel.org, monstr@monstr.eu
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/10] watchdog: xilinx: Allocate private structure per
 device
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com> <255ff18dc52347e1bc8b0a0060eaa1037e02bdaa.1391177880.git.michal.simek@xilinx.com>
In-Reply-To: <255ff18dc52347e1bc8b0a0060eaa1037e02bdaa.1391177880.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/31/2014 06:18 AM, Michal Simek wrote:
> Only one watchdog could be used by this driver.
> Create driver private data structure and move there
> all variables for one instance.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


