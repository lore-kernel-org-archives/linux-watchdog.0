Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47637 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbbEASFU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 1 May 2015 14:05:20 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YoFJP-000TQI-PW
	for linux-watchdog@vger.kernel.org; Fri, 01 May 2015 18:05:19 +0000
Date: Fri, 1 May 2015 11:05:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: max63xx_wdt: Constify platform_device_id
Message-ID: <20150501180515.GA16073@roeck-us.net>
References: <1430494612-30624-1-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430494612-30624-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, May 02, 2015 at 12:36:52AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
