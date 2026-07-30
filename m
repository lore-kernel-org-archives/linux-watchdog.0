Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB73A5E96
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407481; cv=none; b=pksMsILl9qwvufJubR85XTTXt//q0SgaKm/TgxnuOgLi+PSwQc2/wAoJw8RK0Tix71boV8xSvzWIkgK7x97/kVdt2vVnv8/SOdNVjrK4+9r0TiTtYCfMgXTwFgA0Qin2ve89dAYTehKpZZz9eT15S6pai71hnavYlReArOpWwWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407481; c=relaxed/simple;
	bh=MkFho+L+7qIi6ClR+NBgfddbQ9MuhqymAihXj6m77qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnQaoSndFggwFQDbss1tiez0NzsWQ3r1gyEOzdqO9O72VgVnV9edsLujMgBhZp8b5Rqyz5yEoL+s5xFV2b1iReazjMV6LtCVyIrpRnSB227+2bRuwAclFZtTK2xruCtZqpwKis8oFRBAoaqEK1ndvqGIlrwsRAtHVxqnDDQvD64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XJ7TJymY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GAGYu+hX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XJ7TJymY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GAGYu+hX"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UA2UHk677899
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 10:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3FqmpIR1hp9650zedC/Cu7xxjGufkMIKEyfbRtcEbtI=; b=XJ7TJymYZTIxb1yQ
	APCeZ1Nwf6sfl0B294j1PC3xenfdAGPMzTg1oCbkeo8X6i1cERitfxbuHhUKInr6
	SPQ3xYd8a7HvKyDxCBLXNSNW3dTFc2av6rxwjiwIZC0Z+hJhVzIo/mr+MdaH/C7R
	ncnC41eL2vOoQr1Hnrdf9Yv1gxYCn5Ns3tffBX2EhpWX8P6QKZ9Qsf9ERiYG/zrl
	xXtDz5bR+9RcpkXQ5o+Hm38UQDvu7jKKbOBfXt1vXlORoEA6mxDOsZZPxXWSG5uD
	DQpvs65a2uopeEbkjh0ZYWAKfB2sIOMpkx+D0+VDUZFG5C0uyPoZEKPYrIoacX/Q
	zQyl0g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3w60adm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 10:31:18 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-ca8aee88725so2815907a12.3
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785407478; x=1786012278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FqmpIR1hp9650zedC/Cu7xxjGufkMIKEyfbRtcEbtI=;
        b=GAGYu+hXFdsZyJewHlmUAyF3+vG1HdjhWZAEvUGUdmuA1QLDERdgShhEqmBTaxE/7a
         iQz8XxDojNGh5MFFoo1IwNebIF6Nv9kx2e4m+ZbldPBg1MrPbiVz4plutx9eB+1fW3SK
         Ah+igm7w0e8BF82E8LmrhGWldn7eJPyjlYUNzNoAR/AA8mtGUR/N3GSUJjs0F8i0T8sS
         43vabm806Lpg9jiol+uU4dTMGKszsi8zDtqaiPVOiOK/YB7mIkXp1EhJLi8bFQCFKin8
         DVA0wj98++M+4LTYakNfA9d7JD+2WEp7doXnNxlVw5paCyb7G9vqUCu+u3GnlKOuhiDn
         i1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407478; x=1786012278;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3FqmpIR1hp9650zedC/Cu7xxjGufkMIKEyfbRtcEbtI=;
        b=ADh1A8QuEhXiF9OxEscqNc3+QxmBf5UojEc/d2silOEdnGVSlzORdJQjyHM7ClMkU+
         PHb1JmQFZ96c5axg88kk4QhIpKVT2U7HjaofHV/q4SEHlH4vsgcnPJpFeEglERpU/e9g
         LrpxDtbjZ4nu4hGo1yVHMJiGUl7M6SVw+Hdwb0f8HZYwuB1QwwUVqyRCYPpp9jM8TkyD
         urw5nAHuRK6N+bNvYrGCgYyoCyHf/rCvkovyAxJWYHZ+27Y4i6mmmMo/aRiyjIH1i/Sg
         qLIm0n2B5RqbgrEuJQ0enCT9qU1VqyJfIlPR9xzHKZMUsiygxJAcnrxQvOKvVQBWRI1w
         n2Kw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9AeVksa8lsY99Ao9Kb/LhMzly4oX6eVyMxXCmAG84Gc0JS5AwviHVz9hgQZtTF4dFcjnJi1xwNxTrq1wNbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0GlOK1i1n9nXMBq6A0+VN7WYMyK3oBjmixoyTbXgKFmuifUUq
	Duy4zoWK3luA/xEZAUqzuEBgEIryc/8n/fLNfkChK5VKfqGaw52LnGP90sRSNYbj7TgjaXMvjSC
	AVkdC3yMDsjeQfwFSfsVp52xPsw07dFJdAhDmT3cf6DMEQDGCOtasHBFlb/tYuVorFf2a
X-Gm-Gg: AR+sD12TnvnMxdohmCPx4tvRCcnbJVXx6XrXXWbEVrI4kAD6tcXcxN1AwC1+/+7CZNK
	FSwZF2k2HHEcdso5JzotetCEirKhWh6i217e/KLvzlOApJvYex5c1ZZ78D5Vpz11PVb0bdJnXrT
	Wqj9s06BFK8P+XOVtMi2K4IF4vDoBEzS3TbbzKRHyuNH2ZP7PZktoaL6tHDZzoqeA7wsDlUU2lt
	lA4o4tftr2sdz+d4yUk/CycERSQgu+CRVtQUpqqqp7fWM3Sa1dp/KQ6dEkT5X1lecx+ujg6em7E
	pmdJpDhBbI84lRnsSpvi0p+R6+sROHEQ8QJiVLv1D/KYl+3Z5EhkSAlMHqDeaPxwtE7H7Gl0WMO
	yVCgFduRj/j03HOrKb/U+gQidhf5wyKs=
X-Received: by 2002:a05:6a20:d49b:b0:3b3:1c7b:ffb with SMTP id adf61e73a8af0-3c90057a0damr1917892637.34.1785407477721;
        Thu, 30 Jul 2026 03:31:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:d49b:b0:3b3:1c7b:ffb with SMTP id adf61e73a8af0-3c90057a0damr1917858637.34.1785407477220;
        Thu, 30 Jul 2026 03:31:17 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba3518e1sm2024080a12.16.2026.07.30.03.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 03:31:16 -0700 (PDT)
Message-ID: <1fdb31e8-e6a3-47b8-a021-bf05cd61848e@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 16:01:07 +0530
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] watchdog: pretimeout: record PSC reason on
 watchdog pretimeout
To: Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Benson Leung
 <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-arm-msm@vger.org,
        kernel@pengutronix.de, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org
References: <20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com>
 <20260722-pscrr-reboot-reason-v2-3-495ba3005953@oss.qualcomm.com>
 <b7e5b66f-1f27-4c3a-a66d-2100a982aaf4@roeck-us.net>
Content-Language: en-US
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
In-Reply-To: <b7e5b66f-1f27-4c3a-a66d-2100a982aaf4@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA3OCBTYWx0ZWRfX4pfq4dwd5CAz
 tJ4FRStMqdyCSNAINk4MQKU/IgUC3Ma0T2yBSYb0GRdYuvX2DHBWqALO+bUEaTBdcOXYNUWRIrq
 xZALbHuiyLE4qqG/mJrPKAWKw/UvjMw=
X-Authority-Analysis: v=2.4 cv=b9WCJNGx c=1 sm=1 tr=0 ts=6a6b27f6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=hzOxsa2yftWTDtbb7UEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: WBY4KqXQyuX_OVsHttXyllf_S7iYKhoE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA3OCBTYWx0ZWRfX6ghQFTbEloxb
 +jSoR8/4M2FAb30o2k/tkRaMGpSHK4160pOu0BFnlVLXPI2gP6m0NHlqqh2ubYz1X4Jkr0jB306
 VDy+sNImkyzhBzlTat2e1OI8d03CJMkzu5dONQcdKDx/9sxKy99kXhSEoRidbzikn4AWZ7chSNQ
 muPnwlg29PJEgtuo5VVGW7DH8L/nXjz8dL7z8VsCiHaorhDkt+oC1rzOo+hdN5af1ZFlS5kEc88
 BIJCe54mIGWskTkliMyodJk+QMpKZeR/CfZ1GcxKOE6CvW3NIv2JMRj6D9naYBvHMFNvHUlKJQk
 cOib4X+JCsbQwkNSbz0J1P7NV3rRwucNIGOE1A1BuCLskHVBYYx6CnXJ5lBdLtGKwlpAT2IVQZe
 DnQKumUyoAQGW7F+qbhVfYnFCXUr3AOW/C5adQEmif64JXJ2TY/wXRgfzsj20EF7FhTxk9Xw7Eg
 erpmcIulKiCD7GYamrw==
X-Proofpoint-ORIG-GUID: WBY4KqXQyuX_OVsHttXyllf_S7iYKhoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300078


Hi Guenter,

On 30-Jul-26 10:33 AM, Guenter Roeck wrote:
> On 7/22/26 08:13, Faruque Ansari wrote:
>> Update the PSC reset reason by invoking 
>> set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT)
>> from watchdog_notify_pretimeout() before either the panic or 
>> noop governor
>> runs, so the reset cause is committed to persistent storage 
>> before the
>> system goes down.
>>
>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>> ---
>>   drivers/watchdog/watchdog_pretimeout.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/ 
>> watchdog/watchdog_pretimeout.c
>> index 02e09b9e396d..ea48d4eca4aa 100644
>> --- a/drivers/watchdog/watchdog_pretimeout.c
>> +++ b/drivers/watchdog/watchdog_pretimeout.c
>> @@ -4,6 +4,7 @@
>>    */
>>   #include <linux/list.h>
>> +#include <linux/reboot.h>
>>   #include <linux/slab.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/string.h>
>> @@ -103,6 +104,8 @@ void watchdog_notify_pretimeout(struct 
>> watchdog_device *wdd)
>>   {
>>       unsigned long flags;
>> +    set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT);
>> +
> 
> A call to watchdog_notify_pretimeout() does not necessarily reset 
> the system.
> It only resets the system if the panic governor is active. Given 
> that,
> I think this is a bit misleading. If the "noop" governor is 
> active and the
> system crashes later due to a completely unrelated panic, the 
> restart reason
> will be wrongly logged as pretimeout.
> 
Thanks for reviewing.
I agree. My intention was to handle both governors through the 
common pretimeout path. However, with the "noop" governor the 
recorded reason may be misleading since the system can continue 
running.
I'll move the recording to the panic governor path in the next 
version.

Thanks,
Faruque Ansari


