Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42852 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbbAOOrq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Jan 2015 09:47:46 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YBli6-000ub7-Jw
	for linux-watchdog@vger.kernel.org; Thu, 15 Jan 2015 14:47:46 +0000
Message-ID: <54B7D30F.50803@roeck-us.net>
Date: Thu, 15 Jan 2015 06:47:43 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Michal Simek <michal.simek@xilinx.com>,
	linux-kernel@vger.kernel.org, monstr@monstr.eu
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: Remove .owner field from cadence driver
References: <204239650e5bf19ea11cb4b9f41937552324e931.1421325759.git.michal.simek@xilinx.com>
In-Reply-To: <204239650e5bf19ea11cb4b9f41937552324e931.1421325759.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/15/2015 04:42 AM, Michal Simek wrote:
> .owner files is filled by module_platform_driver().
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


