Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:49355 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbaBIUSM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 9 Feb 2014 15:18:12 -0500
Message-ID: <52F7E284.4080603@roeck-us.net>
Date: Sun, 09 Feb 2014 12:18:12 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Michal Simek <michal.simek@xilinx.com>,
	linux-kernel@vger.kernel.org, monstr@monstr.eu
CC: Wim Van Sebroeck <wim@iguana.be>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/10] watchdog: xilinx: Fix OF binding
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com> <26d172891694e4041e73b7dae85a1848adf38034.1391177880.git.michal.simek@xilinx.com>
In-Reply-To: <26d172891694e4041e73b7dae85a1848adf38034.1391177880.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/31/2014 06:18 AM, Michal Simek wrote:
> Use of_property_read_u32 functions to clean OF probing.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


