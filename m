Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792732727;
	b=powPh08TLFj+bdmdYVy81teg0JZEwJVF9agRAA5ROdm9T6noSbO6IMSlRTbR6t4YruYo
	 p6iReEgv26v5tRSnYa6bxQbqEhU3FWPLq5GBhf6G0/FnM6aEXpzimzn0Wf8c8Wd3HZuDo
	 3iqYh4HJ7RkKcP+HoDKDNaKhStcBBPqK+Afmqg7+JFDmZ6mYWJ1RTSQIC+MJ6ZgN1dlZg
	 hw7qLtQdCouZKVSn6KarW4wFCuczATIjMhO7qGKNyakpJwrfCDxykEZfb9zIusD+Eb0F0
	 t7gPBM2LxU6fc3wZvP9dYlQO5SvF3RXxz9fCRQz7TvW19/nVgiA5eavlfzG4cabWbtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792732727;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=H2v7At0gBKH50ptnNc59b5HhlLQje5kkdzxxscMSWWY=;
	b=hlHX9cRtjg+VzIwj8mq0NF5H5o1BWYfdraFGlyYYtJaSgaULz4DexhIOZb0sf/Xv3h4T
	 QkBND3z3PkX+56oPv9Nv3ycSgJO+SYmUp2vk23PcqBYCiU6/2iyT6SBOy4LaL4q7a5a1N
	 nSEtI5tL8iKQHOoFHkRLnt5Eef7Kqpu3S9gLQhScBdt9JqNS2klodYPD+BaojyZybPAuN
	 aU0Wdz1JMpGL9mqbEyeOfNuNzujTj+XLBJrb6jvaPsjD/PluUMz48CmFwhVgzuFfu+lLn
	 3k/DBkBsMQtkOIn3tA5suTYq1BL5gDIPp5lpZ4lhASa+GYcmwXTYVy/x13osYGpx+3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mKbx52ho;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TyjAG6U5;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A15606A31A
	for <linux-watchdog@vger.kernel.org>; Fri, 23 Oct 2026 05:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28A15606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mKbx52ho;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TyjAG6U5
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N1F3Cd2376527
	for <linux-watchdog@vger.kernel.org>; Fri, 23 Oct 2026 05:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H2v7At0gBKH50ptnNc59b5HhlLQje5kkdzxxscMSWWY=; b=mKbx52hoTAsoLR9h
	goDGTxTPzGJ4mQ2inu0l4QHUn5MGLqyVj3TGsUi3h29ouZ9c+y6aBHP1HEJtGcde
	2rOHGwuPlty+tLhqxXsWTl+idci9WlpacVthGW89HWc685xx9KuKx1UiNm0D4rJD
	RHCIbDJGXWH0yyKZrMcCt5tndyayRrhnhvwbMs+UVjGdzH7XwoLL9UiUP+guugUy
	BcXAKJi9apnAVusNg1DH4o3SDSeNG4CusBeWxz358DOUzle4ONKs2EBOxU+gKWmk
	usaA5jXBfAFQeepDCeHk5umgojd7G+brP1RIztYL26+7dyeUT8aqT5DmgiKMk7Yz
	mOr77g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmra0j5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 23 Oct 2026 05:18:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab2395f104so515567a91.2
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Oct 2026 22:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792732725; x=1793337525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H2v7At0gBKH50ptnNc59b5HhlLQje5kkdzxxscMSWWY=;
        b=TyjAG6U5p+0qAk4M8nVJtl6AIDwIBjwuvdROBleoQJsJQsVyDxiPRNTha2KDTQ6wZZ
         nbs84I3bOEmlnRHMaOa15z0+z3jhxeGtQ3rsFoYK0Ic8junLoOcxTwnWWM4FYvjxo+f8
         5XnIMzDDjcKxFRSoX4g1HgdYNi7KS4J2onAgah5U24/9ZUDjlZICcIaskKGt6/MDW8HG
         v7/8eRApK/AH4o9CjS0NX/S89zOibwMPVYygo1ysb4ixmrwdglh/KmmrsT28cyIz3SkZ
         yTnm145DslLnqvZpr4P+RRi705tIE/184TjTlCORpD9ZWo/DUCtHRAu6dlWiDIlU5JKj
         DhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792732725; x=1793337525;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H2v7At0gBKH50ptnNc59b5HhlLQje5kkdzxxscMSWWY=;
        b=PWeFj4fIvaor4jNS0IamG7bo1D7kPmCJcXEGZ03V4JkuFlxgiRJtk0fNXLUUuKDUEw
         iWjp9gkswEUq1hlP12kNVVL4mEjtsRYqqoXWN16VEiB/EwxxMkiSoi4EzrZHH7st9Kxb
         5nORb9Y09XMh1o/0l3WhkNkpYGIfBHo30HUeCkdkzUKvwalF0hbXfVR10FXWAa+AWuTD
         7AdXCVgKbiA2P19SwrJqsCJaA5UMYD9ZxSVFrawxMa/KcNVPilOtC/UOeEY2j3G5Y1/Y
         sUbdN2wjx/942MzrXd1s3tzq5uARx8SPT8lVzXo/PWH13G55SQpSFYq6vpfrd424ahfF
         UbHg==
X-Forwarded-Encrypted: i=1; AKwUvBzHYP1cFrxD/JXZkg+B9w/jP5JLanrXk6W5fsNa10G1p4I/uustFm0DOVd58MBHMDMS/8oeKCbp9oqbhVFBMg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJhimV2S1KZUNRXVHkWS7ZXi+ghPSVoRceyRxgwdNOSv5y7kXM9
	+afDtcHyADutwB4QmOzAoD8PF7u0RFJuroytulJLcv5eZ57n5dUzAe/zcErySHLx/P2XxnPsstI
	KrLagfjoj8xoQKwKARj26GnNvcxqGpOEL1qz98JVXoQRdfyQG0IWkq0NQdgbw9RMsyrRM
X-Gm-Gg: AYBFou0cz6pm1/qyGFgItHY1kT9K5x+i9gsR1BKOtFFeEDcz/Zl2AhFrq2E46HRHAMD
	HW3TwelzcZapJCoGuA/oUfhLVhu0O71rRWEkd2P4x7cRAlVLmMInPwrFDRwF43G8gulfsN2wAQb
	AC0zs6NBluXyvkB6p0SDf4hogtUI0/Qm/Jmz8Aeye3JDdnAHhzNnLkYsvwWBSvZogQ60mfdMuL3
	ARRxGXUSj1pQo/ttzsUBbS+44mja/d4WUFiaIyCc1XVkJQXe5HDzqhKMReM36nAjB4Ok2ztnp8C
	E43nbuKp+tH7oqOEOz1SIZJqDwExolfijrs2YFUwlz5JQg1YWJHds3R/yOhHqlGrECeimM4BBZz
	24pry7KUI8oAjOy156oE7qrY3aJSWKA==
X-Received: by 2002:a17:90b:4a09:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3adce6292c0mr889142a91.25.1792732724472;
        Thu, 22 Oct 2026 22:18:44 -0700 (PDT)
X-Received: by 2002:a17:90b:4a09:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3adce6292c0mr889096a91.25.1792732723727;
        Thu, 22 Oct 2026 22:18:43 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba8a5342sm317639a12.17.2026.10.22.22.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 22:18:42 -0700 (PDT)
Message-ID: <30526f3e-8d44-444f-835e-a8e4f6befcc8@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:48:32 +0530
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] power: reset: Add PSCRR NVMEM recorder
To: Srinivas Kandagatla <srini@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260914-pscrr-provider-v3-0-c45cb16542e8@oss.qualcomm.com>
 <20260914-pscrr-provider-v3-2-c45cb16542e8@oss.qualcomm.com>
 <060c3f44-2567-4b09-8d00-f38b92339029@kernel.org>
Content-Language: en-US
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
In-Reply-To: <060c3f44-2567-4b09-8d00-f38b92339029@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: v2tzXI5XhZqh6QjXUM27Z_RJTDVRmgYZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyMCBTYWx0ZWRfXxDCSnJ4ss8MT
 nO4ybKOSu1GOhGXsuNCy0Qa+LNPPoCos9vZ/D7VA20QfkupKaIWEslOI4WX/zKHZNMRqhl26buV
 rjJAcW3fe8hEVhGzgjsJZJSQWvrx9l0=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adaee35 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=mMMiByi50vCrbbtk434A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyMCBTYWx0ZWRfXyxviF+aQWYHG
 yesDP6bPZbjDVbhez8mBoijLyO4F6aLgT85avS4nGvB7eIUkLIz7uj1ssVverr1RDU37HB+pYXM
 yqedZwqjfiZCm+hACgpM5EO+2NrBmJlzBzP4pzLpRkzucAe8TrLPfT0Ngt98Fxueh8t9ObZe9nT
 xBczwK3cZnXN53yhjFb4fqtWk48byl693356Ac9W+NM+loZ2wsgVDJVAfZaRFIs9qi14l2vLZtY
 cdkbdVKHiAS3QuhHx88JkR9lqIhZe70W4Qme6G4Nd9r3CYdy0Tt9tGYCwGrFu/qHfMljo5Ibkj+
 DrOk5uhdv1QiQp5wSpf7Jyht/RL3poB5Y9SWyLzrnE+Xg/hMKDAztDg6AsMXUXy3QY14wcV2gAt
 UDbMMBammuJVPEdXt1l3mLLXGBm+afAOL3bex7XXjIm1QkKv6T8i/CDWjamt1pLY3Gq/AG6sjn4
 dBb9cRMstoQgOLwhGag==
X-Proofpoint-ORIG-GUID: v2tzXI5XhZqh6QjXUM27Z_RJTDVRmgYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230020

Hi Srinivas,

On 22-Oct-26 1:24 PM, Srinivas Kandagatla wrote:
> 
> 
> On 9/14/26 5:38 AM, Faruque Ansari wrote:
>> Record the power state change reason into a NVMEM cell (a PMIC
>> SDAM byte, RTC scratch register, or EEPROM) and read it back on the
>> next boot, so the cause survives a power cycle.
>>
>> The recorder is implemented as an NVMEM layout driver: it owns the
>> single cell described by its layout binding and adds it to the
>> parent NVMEM device, rather than acting as a standalone consumer of
>> someone else's cell.
>>
>> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>> ---
>>   drivers/power/reset/pscrr/Kconfig       |  14 ++
>>   drivers/power/reset/pscrr/Makefile      |   1 +
>>   drivers/power/reset/pscrr/pscrr-nvmem.c | 269 ++++++++++++++++++++++++++++++++
> 
> Consider moving this to drivers/nvmem, as this is an independent driver
> and no dependency to drivers/power headers.

Thanks for your review and suggestion.
Sure, I'll move this driver under drivers/nvmem/layout in the 
next revision.

> 
>>   3 files changed, 284 insertions(+)
>>
>> diff --git a/drivers/power/reset/pscrr/Kconfig b/drivers/power/reset/pscrr/Kconfig
>> index 72de82731b53..459b05ba32d3 100644
>> --- a/drivers/power/reset/pscrr/Kconfig
>> +++ b/drivers/power/reset/pscrr/Kconfig
>> @@ -31,3 +31,17 @@ menuconfig PSCRR
>>   	  unless hardware provides the reset cause.
>>   
>>   	  If unsure, say N.
>> +
>> +if PSCRR
>> +
>> +config PSCRR_NVMEM
>> +	tristate "PSCRR NVMEM recorder provider"
>> +	depends on NVMEM_LAYOUTS
>> +	help
>> +	  PSCRR recorder that stores the power state change reason in a
>> +	  small NVMEM cell (such as an RTC scratch register) and reads it
>> +	  back on the next boot, so the cause survives a power cycle.
>> +
>> +	  If unsure, say N.
>> +
>> +endif # PSCRR
>> diff --git a/drivers/power/reset/pscrr/Makefile b/drivers/power/reset/pscrr/Makefile
>> index e5530a858971..95c80c80c7da 100644
>> --- a/drivers/power/reset/pscrr/Makefile
>> +++ b/drivers/power/reset/pscrr/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-$(CONFIG_PSCRR) += pscrr.o
>> +obj-$(CONFIG_PSCRR_NVMEM) += pscrr-nvmem.o
>> diff --git a/drivers/power/reset/pscrr/pscrr-nvmem.c b/drivers/power/reset/pscrr/pscrr-nvmem.c
>> new file mode 100644
>> index 000000000000..64f67f0521e0
>> --- /dev/null
>> +++ b/drivers/power/reset/pscrr/pscrr-nvmem.c
>> @@ -0,0 +1,269 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * pscrr-nvmem.c - NVMEM layout driver for PSCRR
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * Copyright (C) 2025 Pengutronix, Oleksij Rempel <o.rempel@pengutronix.de>
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/module.h>
>> +#include <linux/nvmem-consumer.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/of.h>
>> +#include <linux/pscrr.h>
>> +#include <linux/slab.h>
>> +
>> +struct pscrr_nvmem {
>> +	struct nvmem_device *nvmem;
>> +	u32 offset;		/* byte offset of the cell, from reg[0] */
>> +	u32 bit_offset;		/* 0 when the cell has no "bits" property */
>> +	u32 nbits;		/* BITS_PER_BYTE when the cell has no "bits" property */
>> +	enum psc_reason reason;
>> +};
>> +
>> +static inline u8 pscrr_nvmem_mask(struct pscrr_nvmem *priv)
>> +{
>> +	return (u8)GENMASK(priv->bit_offset + priv->nbits - 1, priv->bit_offset);
>> +}
>> +
>> +static int pscrr_nvmem_raw_read(struct pscrr_nvmem *priv, u8 *raw)
>> +{
>> +	int ret;
>> +
>> +	ret = nvmem_device_read(priv->nvmem, priv->offset, sizeof(*raw), raw);
>> +
>> +	return ret < 0 ? ret : 0;
>> +}
>> +
>> +static int pscrr_nvmem_raw_write(struct pscrr_nvmem *priv, u8 raw)
>> +{
>> +	int ret;
>> +
>> +	ret = nvmem_device_write(priv->nvmem, priv->offset, sizeof(raw), &raw);
>> +
>> +	return ret < 0 ? ret : 0;
>> +}
>> +
>> +static int pscrr_nvmem_cell_read(struct pscrr_nvmem *priv, u8 *out)
>> +{
>> +	u8 raw, mask = pscrr_nvmem_mask(priv);
>> +	int ret;
>> +
>> +	ret = pscrr_nvmem_raw_read(priv, &raw);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*out = (raw & mask) >> priv->bit_offset;
>> +
>> +	return 0;
>> +}
>> +
>> +static int pscrr_nvmem_cell_write(struct pscrr_nvmem *priv, u8 val)
>> +{
>> +	u8 raw, mask = pscrr_nvmem_mask(priv);
>> +	int ret;
>> +
>> +	/* Sub-byte cell: preserve the neighbouring bits, read-modify-write. */
>> +	if (priv->nbits < BITS_PER_BYTE) {
>> +		ret = pscrr_nvmem_raw_read(priv, &raw);
>> +		if (ret)
>> +			return ret;
>> +	} else {
>> +		raw = 0;
>> +	}
>> +
>> +	raw = (raw & ~mask) | ((val << priv->bit_offset) & mask);
>> +
>> +	return pscrr_nvmem_raw_write(priv, raw);
>> +}
>> +
>> +static int pscrr_nvmem_read_reasons(struct pscrr_provider *p,
>> +				    unsigned long *reasons)
>> +{
>> +	struct pscrr_nvmem *priv = p->priv;
>> +
>> +	/*
>> +	 * Report the reason latched at probe (or overwritten by a later
>> +	 * record); the cell itself was cleared at probe, so it is not read
>> +	 * live here.
>> +	 */
>> +	set_bit(READ_ONCE(priv->reason), reasons);
>> +
>> +	return 0;
>> +}
>> +
>> +static int pscrr_nvmem_write_reason(struct pscrr_provider *p,
>> +				    enum psc_reason reason)
>> +{
>> +	struct pscrr_nvmem *priv = p->priv;
>> +	int ret;
>> +
>> +	if (reason >= PSCR_REASON_COUNT)
>> +		return -EINVAL;
>> +
>> +	ret = pscrr_nvmem_cell_write(priv, reason);
>> +	if (ret)
>> +		return ret;
>> +
>> +	WRITE_ONCE(priv->reason, reason);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pscrr_provider_ops pscrr_nvmem_ops = {
>> +	.read_reasons = pscrr_nvmem_read_reasons,
>> +	.write_reason = pscrr_nvmem_write_reason,
>> +};
>> +
>> +static struct device_node *pscrr_nvmem_get_cell(struct device *dev,
>> +						struct nvmem_device *nvmem,
>> +						u32 reg[2])
>> +{
>> +	struct device_node *layout_np, *cell_np = NULL;
>> +
>> +	layout_np = of_nvmem_layout_get_container(nvmem);
>> +	if (!layout_np)
>> +		return ERR_PTR(-ENOENT);
>> +
>> +	for_each_child_of_node_scoped(layout_np, child) {
>> +		if (of_property_read_u32_array(child, "reg", reg, 2))
>> +			continue;
> Please explain this, why are you ignoring child with reg? to start with
> are you expecting child nodes without reg property?

ACK.
Yes. Child nodes without a reg property are expected when the 
complete byte is reserved for a single cell. If only a portion of 
the byte is being used (e.g. 4 bits out of 8 bits), then the 
child node should provide a reg property to describe the bit range.>
>> +
>> +		cell_np = of_node_get(child);
> You are getting only the first child? Please explain why this is not
> inline with the bindings or vice-versa.

ACK.
Agree — silently taking the first child was wrong. PSCRR records 
one reason into one cell, and the binding describes exactly one 
reason cell.
I'll fix this so the driver returns an error in both out-of-spec 
cases instead of guessing:
- more than one cell  -> -EINVAL ("expected a single pscr nvmem 
cell")
- zero cells          -> -ENOENT ("missing pscr nvmem cell")


> 
>> +		break;
>> +	}
>> +	of_node_put(layout_np);
>> +
>> +	return cell_np ?: ERR_PTR(dev_err_probe(dev, -ENOENT,
>> +						"missing pscr nvmem cell\n"));
>> +}
>> +
>> +static int pscrr_nvmem_add_cells(struct nvmem_layout *layout)
>> +{
>> +	struct device *dev = &layout->dev;
>> +	struct pscrr_nvmem *priv;
>> +	struct device_node *cell_np;
>> +	struct nvmem_cell_info info = { };
>> +	u32 reg[2], bits[2];
>> +	u8 val;
>> +	int ret;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->nvmem = layout->nvmem;
>> +
>> +	cell_np = pscrr_nvmem_get_cell(dev, priv->nvmem, reg);
>> +	if (IS_ERR(cell_np))
>> +		return PTR_ERR(cell_np);
>> +
>> +	/* The reason is a single byte; a bit cell still occupies one. */
>> +	if (reg[1] != sizeof(val)) {
>> +		of_node_put(cell_np);
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "unsupported pscr nvmem cell size\n");
> 6 such instances with same exit point, consider using label.

ACK. I'll address this in the next revision.
>> +	}
>> +	priv->offset = reg[0];
>> +
>> +	if (!of_property_read_u32_array(cell_np, "bits", bits, ARRAY_SIZE(bits))) {
>> +		priv->bit_offset = bits[0];
>> +		priv->nbits = bits[1];
>> +	} else {
>> +		priv->bit_offset = 0;
>> +		priv->nbits = BITS_PER_BYTE;
>> +	}
>> +
>> +	if (priv->bit_offset + priv->nbits > BITS_PER_BYTE * reg[1]) {
>> +		of_node_put(cell_np);
>> +		return dev_err_probe(dev, -EINVAL, "bits exceed cell size\n");
>> +	}
>> +
>> +	/* PSCR_REASON_COUNT must fit in the allotted bits. */
>> +	if (PSCR_REASON_COUNT > (1U << priv->nbits)) {
>> +		of_node_put(cell_np);
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "too few bits for the reason range\n");
>> +	}
>> +
>> +	/*
>> +	 * The cell survives resets, so at boot it still holds whatever the
>> +	 * previous session recorded before it went down. Latch that as this
>> +	 * boot's reason, then clear the cell back to PSCR_UNKNOWN: if this
>> +	 * session is later cut short by an abrupt reset that never runs the
>> +	 * recorder (watchdog power-cycle, sudden power loss), the next boot
>> +	 * reads "unknown" instead of a stale reason left over from an earlier
>> +	 * cycle.
>> +	 */
> Looks unnecessary comment tbh, has no value to the user.
ACK. I will remove this in the next revision.>
>> +	ret = pscrr_nvmem_cell_read(priv, &val);
>> +	if (ret) {
>> +		of_node_put(cell_np);
>> +		return dev_err_probe(dev, ret,
>> +				     "failed to read the pscr nvmem cell\n");
>> +	}
>> +
>> +	priv->reason = val < PSCR_REASON_COUNT ? val : PSCR_UNKNOWN;
>> +
>> +	ret = pscrr_nvmem_cell_write(priv, PSCR_UNKNOWN);
>> +	if (ret) {
>> +		of_node_put(cell_np);
>> +		return dev_err_probe(dev, ret,
>> +				     "failed to clear the pscr nvmem cell\n");
>> +	}
>> +
>> +	info.name = kasprintf(GFP_KERNEL, "%pOFn", cell_np);
>> +	if (!info.name) {
>> +		of_node_put(cell_np);
>> +		return -ENOMEM;
>> +	}
>> +	info.offset = reg[0];
>> +	info.bytes = reg[1];
>> +	info.bit_offset = priv->bit_offset;
>> +	info.nbits = priv->nbits;
>> +	info.np = cell_np;
>> +
>> +	ret = nvmem_add_one_cell(priv->nvmem, &info);
>> +	kfree(info.name);
>> +	if (ret) {
>> +		of_node_put(cell_np);
>> +		return ret;
>> +	}
>> +
>> +	return PTR_ERR_OR_ZERO(devm_pscrr_provider_register(dev, "nvmem",
>> +							    &pscrr_nvmem_ops, NULL,
>> +							    priv));
>> +}
>> +
>> +static int pscrr_nvmem_probe(struct nvmem_layout *layout)
>> +{
>> +	layout->add_cells = pscrr_nvmem_add_cells;
>> +
>> +	return nvmem_layout_register(layout);
>> +}
>> +
>> +static void pscrr_nvmem_remove(struct nvmem_layout *layout)
>> +{
>> +	nvmem_layout_unregister(layout);
>> +}
>> +
>> +static const struct of_device_id pscrr_nvmem_of_match[] = {
>> +	{ .compatible = "pscrr-nvmem" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, pscrr_nvmem_of_match);
>> +
>> +static struct nvmem_layout_driver pscrr_nvmem_layout = {
>> +	.driver	= {
>> +		.name		= "pscrr-nvmem",
>> +		.of_match_table	= pscrr_nvmem_of_match,
>> +	},
>> +	.probe	= pscrr_nvmem_probe,
>> +	.remove	= pscrr_nvmem_remove,
>> +};
>> +module_nvmem_layout_driver(pscrr_nvmem_layout);
>> +
>> +MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
>> +MODULE_AUTHOR("Faruque Ansari <faruque.ansari@oss.qualcomm.com>");
>> +MODULE_DESCRIPTION("NVMEM recorder provider for PSCRR");
>> +MODULE_LICENSE("GPL");
>>
> 

