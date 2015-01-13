Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44456 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbbAMMKM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 13 Jan 2015 07:10:12 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YB0IX-001XnJ-21
	for linux-watchdog@vger.kernel.org; Tue, 13 Jan 2015 12:10:13 +0000
Message-ID: <54B50B20.9010602@roeck-us.net>
Date: Tue, 13 Jan 2015 04:10:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2: Constify struct regmap_config and watchdog_ops
References: <1420448957-10106-1-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1420448957-10106-1-git-send-email-k.kozlowski@samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/05/2015 01:09 AM, Krzysztof Kozlowski wrote:
> The regmap_config struct may be const because it is not modified by the
> driver and regmap_init() accepts pointer to const. Make struct
> watchdog_ops const as well.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


