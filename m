Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55901 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbbBKOB6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 Feb 2015 09:01:58 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YLXrS-001uEY-Rg
	for linux-watchdog@vger.kernel.org; Wed, 11 Feb 2015 14:01:51 +0000
Message-ID: <54DB60B5.4040403@roeck-us.net>
Date: Wed, 11 Feb 2015 06:01:25 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
	linux-watchdog@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] watchdog: mtk_wdt: signedness bug in mtk_wdt_start()
References: <20150211102621.GC18515@mwanda>
In-Reply-To: <20150211102621.GC18515@mwanda>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/11/2015 02:26 AM, Dan Carpenter wrote:
> "ret" should be signed for the error handling to work correctly.  This
> doesn't matter much in real life since mtk_wdt_set_timeout() always
> succeeds.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

