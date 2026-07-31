Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D6E35203C
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476176; cv=none; b=jIFpTlraVvUUYD0c8CP1pUcvq32xUCAZUvqogg9LHEf77iWlk+eOSpT/c5Gn3mKQgBo5quO96QbxIOaapBKRSt/zmk80IyJPus4aIp+6qFU6Jdz2cPDnvtojamiiocw4lFLJIUqsrslbWNj8l71Kbbzft1iGcQrnFJ+91pdCIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476176; c=relaxed/simple;
	bh=HlCj3OUYyqKtQ/5rTQybZUxn2k8hK828D1vbxPLMmSU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qzjzpr4+BxoX7pNZz2jCG36TuZwPCmSE2gr0NM/bsN6KRtWNmxVduVo7PF8GVl06RHMABaScPj1BQj5deB+QI6dHNHkLbjG0UEgbwW4++q1KPjawKObyBCYH0PSmOIav6qUXD3Rxnos7bFZKiZ4v+46ClOHO9ivjU70azdQ3Xqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RIGQzT9A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LTqW3grq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RIGQzT9A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LTqW3grq"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V4uje42860069
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 05:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jysv5gPSXcvU8IySyVYB1omnrR7juLYqFiyOpg6lF6w=; b=RIGQzT9AraOLTzZ9
	bdoKEJFVrrZFwumzgB4E0h6ZfE2CSQALZ1Hn81cHOj0KMRiHeobwba0AP2zvt7HE
	EgFbXylJN8I9knulVquIq0KKMbGR9F6e6H+R0WFv9nPEogT7l15x6oeoJ5UIp5O5
	aoiW6uJnI1aFgs7CkhX2j2wHoPgLbylxj0gwqs/wFeUYOCOTraIaH99JH5g4BAxb
	1VlezU7G1ot84K3ZVEUhAfVh3Jh5pdg1+HZ7fC0LjUiFpwpfi7OP4NRsXkwvth45
	mVB4n9M/fIGfnVxUHVBYjuYn30/0de1FGe+qEO/+coRDDP4//TSpEIeQ9/uiFVSf
	QYHoEg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frmyqg4kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 05:36:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so5038585ad.1
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 22:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785476173; x=1786080973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jysv5gPSXcvU8IySyVYB1omnrR7juLYqFiyOpg6lF6w=;
        b=LTqW3grq02LWt8Cw2WPsPK1WuPDkz37EZNqFudC+ZI88O3PU1QBYMxq+awr87s+Iqx
         pAD6ydTju+0ET4uyWKfiaocNY2hevCqFPEnsrprAFNkdJpxNsJLNStB3IopwlmQJSZIj
         O5xSXPu/Wef/pGE5Ngg2cPuAU/eODvXLK384eVsho32AGESPhLjRcfJ5szggXJ529umg
         cy8CvwPAfriqELWmw70YDIhDJgMwk8kMuyUSzhN07d1EKxYYBIyTMLSWsXQbI4m7V3P9
         QlyBeY72/Lzp8NcrHxsYuYBz5JYErIiDcTIuxe1gzPzGho3pwL/a3v2+Q4CVQKqF5jt8
         +4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476173; x=1786080973;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jysv5gPSXcvU8IySyVYB1omnrR7juLYqFiyOpg6lF6w=;
        b=ZlA/qNY1L1RvG+Fqa3uR6aX1LVDk4jJMhWxDY+YjAJSNCfOBP1P5HbTOYCJDyBssyK
         Mm91rjanSm+hQRX2Ca/F9IQD3B5ny13c4OUU9mS+9ecMfGwMjgZjqzl5eyVCAIttDXvS
         0ZODiCVJ07yrcK9f1DRJ2hNjMBD3boeZBcliBTXau9DrQJh3nTV7VcoxgxhMNLROyFxz
         ozKNgIEJrAdor1YdzgOManZWt9YRzfq13GvVD2LOoruxHAj1K05b1GH8TLlonG38/7HG
         frsEKqO9do/e9jnDirvwk0N95w9o7mtwb2kCrb61o0bsicrrtOv+K7wgL/X4TSnpXsFI
         kywg==
X-Forwarded-Encrypted: i=1; AHgh+RpMSjTr4psIzjGRj+nGgvCNRJQNbLkvMhu/hEw44Go5kFQhDLMZkTO+Tx8/jVOAWGNwxc14Jt0z4C4JUIP09A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLm1KJL7Kh3PfNL2QrkJF6Kqx+zgpywTHgTVr2u5sQ1MUM2s+x
	Ud+IjCRWRE1Zvvs1uRjf1wMvXvUu9zd70wNZpxu5xdcbisx1bpLVxWpLljX48RGnULeJPjlwGiz
	QGf8vep1R19EQznpdi4yicNZMELMzSHtt3j7kriOyGHjqTt9RxmjmQJ5fyokzu1GOE6nA
X-Gm-Gg: AR+sD100LIQt8ez5uIqOE72KAtB5/L0Y+/4+3oFoLfV2SAg3J1IhDMKgvPUMnQuOxbz
	HI/eky2H8TjLXccnwyZhkpwjk8w2b3kCBUuH1pW84wLrv0a/3/raUAIW4c7DhjjtTPJ2Oe+NFPG
	fmJGdCCYMZcDTV7YJZgUjP3+rFmLoZyKdVvJBfW31ESugoA+zHu1Xmxji/QeoQha94q4O4Ok+6+
	f7dJyvfaTnEf7onXgmc8sovQ0buOsb94lR2CyLOUxycudhRXVlKvVs7zE6mX+Ht2v6PB+rj6LBK
	fNwJtEnFDNaKhke/2EyZImQG/tHPRf1v+SKgKkJiEed7kzyqUB3rXD6Ip4T2ZCI4lQ+knsc01kU
	B+hQQpq0aHGvWovnO5qMHn+uXMQYfmZs=
X-Received: by 2002:a17:90b:33ce:b0:38f:1f8:1fa with SMTP id 98e67ed59e1d1-38fb11f3accmr613811a91.15.1785476172867;
        Thu, 30 Jul 2026 22:36:12 -0700 (PDT)
X-Received: by 2002:a17:90b:33ce:b0:38f:1f8:1fa with SMTP id 98e67ed59e1d1-38fb11f3accmr613786a91.15.1785476172302;
        Thu, 30 Jul 2026 22:36:12 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm169062a91.13.2026.07.30.22.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 22:36:11 -0700 (PDT)
Message-ID: <e6b4a5f9-8df1-4adf-ad7a-ea1e9dd4a88d@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 11:06:03 +0530
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] power: reset: pscrr: add watchdog pretimeout
 reason tracking
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-msm@vger.org, kernel@pengutronix.de,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?UTF-8?Q?S=C3=B8ren_Andersen?=
 <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org
References: <20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com>
 <20260722-pscrr-reboot-reason-v2-2-495ba3005953@oss.qualcomm.com>
 <98e65507-3084-4948-8096-4e2d8d20dc81@gmail.com>
 <amrgDC0s3rb5Xv4N@pengutronix.de>
Content-Language: en-US
In-Reply-To: <amrgDC0s3rb5Xv4N@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzNSBTYWx0ZWRfX6qxvUzkN0saJ
 qO+n8Ji8u7J1GvxvWp3gT0ZAYzCTuyM5aasZ7SwP58v72ImdFcaY6ay64UyE3PPA12oBi38ehUZ
 g31EA81xBabQqdBJ72FY+D+QatDZwEo=
X-Proofpoint-GUID: Rko1EDQg_nr-Ta-omCU11BXGeHUOgv5Z
X-Proofpoint-ORIG-GUID: Rko1EDQg_nr-Ta-omCU11BXGeHUOgv5Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzNSBTYWx0ZWRfX5WKSrDIRuqSa
 qe6rgAk1WmRCEzDlSCMv6sdomeLG3NmW1Zoni+0o1zDS+F/GIMFpwuylEVassd7DjastoOP3mEq
 tufAzSp4oDtX/K9uOFNJNQZ69dGwENTDPZ/+OSfDdKvDc8XYoBpWdAcMiCC+zYjcOGCpN9gBGx0
 hp6IwpCxOn4zdSchWakiK3cqsBEC3ivue54Sb3/vl6TQ/rjWU6hCV3fQyq0emmVIY9ZqfYGhorX
 8dMHEkk5vjH3iW9P2i8T/G6eAdA7VbukXQ7mBiMd3aTdU0HnHobjU2qEYmiyU5vO38KA9plyKE0
 b05H+Tvz/ZmlBvHe7r1Prcayg+I/H037/2hW37GEmIXwKg4O15NUZCURMGa3+UT6IR5X6uyKmdu
 m689uCH+bKWX20FmixbnnCIwI/EFtCWS5tGIWvQcvuC4qrdHvLp3aT7gjEryRQvIdOm3SzzZk73
 Rma3N+TwWPEOzP/Dv1w==
X-Authority-Analysis: v=2.4 cv=Xb65Co55 c=1 sm=1 tr=0 ts=6a6c344d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=w9q8cTZDPmzYZkvZMkcA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310035

Hi Matti,

On 30-Jul-26 10:54 AM, Oleksij Rempel wrote:
> Hi Matti,
> 
> On Thu, Jul 30, 2026 at 07:49:41AM +0300, Matti Vaittinen wrote:
>> On 22/07/2026 18:13, Faruque Ansari wrote:
>>> Watchdog pretimeout resets are not recorded with a dedicated reset
>>> reason, causing subsequent boots to report PSCR_UNKNOWN and making it
>>> difficult to distinguish them from other unexpected resets.
>>>
>>> Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reset reason code and
>>> prevent the panic notifier from overwriting a watchdog pretimeout
>>> reason with PSCR_KERNEL_PANIC when the pretimeout governor triggers a
>>> panic.
>>>
>>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>>> ---
>>>    drivers/power/reset/pscrr.c           | 7 ++++++-
>>>    include/linux/power/power_on_reason.h | 1 +
>>>    include/linux/reboot.h                | 1 +
>>>    kernel/reboot.c                       | 1 +
>>>    4 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
>>> index b5906f127e88..5b107c62fe82 100644
>>> --- a/drivers/power/reset/pscrr.c
>>> +++ b/drivers/power/reset/pscrr.c
>>> @@ -149,7 +149,12 @@ static int pscrr_panic_notifier(struct notifier_block *nb,
>>>    	if (!backend || !backend->ops || !backend->ops->write_reason)
>>>    		return NOTIFY_OK;
>>> -	set_psc_reason(PSCR_KERNEL_PANIC);
>>> +	/*
>>> +	 * Do not overwrite a previously recorded watchdog pretimeout reason
>>> +	 * during panic handling.
>>> +	 */
>>> +	if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
>>> +		set_psc_reason(PSCR_KERNEL_PANIC);
>>
>> Hi Faruque,
>>
>> I like the idea of adding WDG pretimeout resets in pscrr. I am just
>> wondering what makes WDG reason so special, that it shouldn't be overwritten
>> while other reasons can be? Can this notifier be called (now or in the
>> future) so, that there are other reasons getting overwritten?

I agree. WDG is not a special case - it is just one scenario that 
I have tested. There are many similar cases in the kernel.

In the case of WDG, the WDG is the primary reason for the system 
reboot. The kernel panic is only a side effect of the WDG event. 
Therefore, I am recording the reboot reason based on the actual 
root cause, which is the reboot initiated by WDG.

Yes, the notifier will still be called and may overwrite the 
reboot reason with another reason.

Thanks,
Faruque Ansari
