Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52386 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbbCaPJC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 31 Mar 2015 11:09:02 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Ycxmn-000WQx-6i
	for linux-watchdog@vger.kernel.org; Tue, 31 Mar 2015 15:09:01 +0000
Message-ID: <551AB86F.9010407@roeck-us.net>
Date: Tue, 31 Mar 2015 08:08:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Baruch Siach <baruch@tkos.co.il>, Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] watchdog: digicolor: document device tree binding
References: <9995b9d0be8cda30103be7406a781cd79f347aeb.1427782499.git.baruch@tkos.co.il>
In-Reply-To: <9995b9d0be8cda30103be7406a781cd79f347aeb.1427782499.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/30/2015 11:14 PM, Baruch Siach wrote:
> Add a device tree binding documentation to the watchdog hardware block on the
> Conexant CX92755 SoC. The CX92755 is from the Digicolor SoCs series. Other SoCs
> in that series may share the same hardware block.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

