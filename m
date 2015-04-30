Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40680 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750912AbbD3LNj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Apr 2015 07:13:39 -0400
Message-ID: <55420E29.2050504@st.com>
Date: Thu, 30 Apr 2015 13:12:41 +0200
From: Maxime Coquelin <maxime.coquelin@st.com>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <kernel@stlinux.com>,
	<a.zummo@towertech.it>, <david.paris@st.com>, <wim@iguana.be>,
	<linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>
Subject: Re: [STLinux Kernel] [PATCH v7 4/9] ARM: STi: DT: STiH407: Add Device
 Tree node for the LPC
References: <1428590854-14095-1-git-send-email-lee.jones@linaro.org> <1428590854-14095-5-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1428590854-14095-5-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 04/09/2015 04:47 PM, Lee Jones wrote:
> On current ST platforms the LPC controls a number of functions.  This
> patch enables support for the LPC Watchdog and LPC RTC devices on LPC1
> and LPC2 respectively.
>
> Signed-off-by: David Paris <david.paris@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/boot/dts/stih407-family.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
>

Applied to sti-dt-for-v4.2.

Thanks!
Maxime
