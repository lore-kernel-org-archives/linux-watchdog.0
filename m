Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3470D346A1C
	for <linux-watchdog@vger.kernel.org>; Tue, 21 Jul 2026 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631915; cv=none; b=gFZ81r8GE/y+kwUKVvRroO9xWrTIRhfY1vFq1IgWxd12OTOiTHBbuW4H5l4nK9r2mQwBG6HcHzs9KPYYURBuO0RHISOGtojOZTgQDQJMANZzPzaGJM+5+lUqa4UPMrdo4Bhq5qx/OY7i1tXNXnmr2wKsVsdKtyxu6qvdgSPHnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631915; c=relaxed/simple;
	bh=5vLtRZl0KY1lopmT7Vey9A6ugpTj+4/jRYXPaak9q5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOv5MThsrbPhbEQODj6RVvEPg0DKhpem165wGGYiuCNGZbZZiszb53rb7zTVR7tj9KRPkV3CzRJoIW9P2kDzadypnO6XeptH+WH/kLjeU49oS2jH2Duo/zV0uWW3w3bOqPEraK9VD94V06Nnq48ysPX4WPsF7JBi7JQAk72ydoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fL3Rroxs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OYB+j2Mb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fL3Rroxs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OYB+j2Mb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LARJMH1385818
	for <linux-watchdog@vger.kernel.org>; Tue, 21 Jul 2026 11:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PUXrHGT89/HXVVPekH8oE4K2uUkHmOQY+kGVM52cxQY=; b=fL3RroxsPpMOxRp5
	Mf3wh4o4it64oq9GJGIBZl4beI/tFzYST3GhOpERDbdWWFlBoGKHK/0lzZAbOtwf
	SfRtwsG4cXrjV+ua7FNKIiKZTwmoYBsIuAx5GueE88h60KA5JZ4xChfjjdjr0KOJ
	sMBCt++MTLbY71sWAn1SzFrofEnAybd9Wh7aNCeSDquf6q/QZne8L0imiGrD4Kng
	BnFGQIflMndbWKcon3tezbjKbE2iEHugWl+GYPFnjcvM5byuQsyUc3bKfw21ZGa0
	pagzNLrYkipc2CzUatAcrOjKpGY2E+LfYMUyRSWPmoTILB4XY15WZYPqXFllFokx
	eT8iZQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1se1qtj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 21 Jul 2026 11:05:12 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccafc5e82cso104569595ad.3
        for <linux-watchdog@vger.kernel.org>; Tue, 21 Jul 2026 04:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784631912; x=1785236712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PUXrHGT89/HXVVPekH8oE4K2uUkHmOQY+kGVM52cxQY=;
        b=OYB+j2MbPyflXAHpZq5zc+D9G0VWAQOnZoDYsv0a8rwmW0DnV305CiJrTVsK+9V18b
         H5SufvIE8olniYw/a87Lb6/Ff7jACf+jgvxtyG3Pp3PrWdn4eO3fM077Dgs0oU3VtpNH
         lDKcBUzhE6hHneqSmELqrEIsNwqYVl1zJaitPFlbbspo0mFMjRduznG9zlrTKsnxaoNI
         HbmqZc1kTz9zaLljTsPjwSMVz5LlmdrxfqUyXYuxEcYCa7rizx/zXyrOBvkAYXoiVZm/
         khsfrRsBlGF0B/LhQRk6C3SDAJFVEtFG+iLgOKtwJPP8F55+vHrjjjxEcEO0uJFG4izZ
         tgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784631912; x=1785236712;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUXrHGT89/HXVVPekH8oE4K2uUkHmOQY+kGVM52cxQY=;
        b=NX9TbVfblQzL3CNaY6Ooyokzw+GkG/04skC0db0V4uUFRhxtIhJl2aWF9gSNpAzocH
         Xyoav9/2WCx5fFoo1ClNmIScCGcaNI42SPznpLL/zgVmRdXG+LyEaVqHJZRDy0pWQ7fd
         9r8BQKNS/2MNIspqb5cRxeB9+FiAH8K8ZSf4KOzHoYb+RVwgpRAokN2J4neR9/CTEsKE
         iNAk/Iz5BF40a6zRLIa4RMPcHWCFQceJqdAFkVBfagxn9shWPEEfuk3a0OI8LQcFgi/r
         MHAHhXPmdR27OC0p3nTWoeyGF836y+xOm3RWHR0EC8ef6KuRyN5ZgGEVc/U46cedqbOY
         oeOQ==
X-Forwarded-Encrypted: i=1; AHgh+RrI4T6iZi/ViYScMuKCUy0ITc2v7mp20l4oVwNBmhZmSqki/xbi0b/uOFzxdaBYP0ZezuL+okFOdS7rwhzryQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGB6Vhb2dxZ7iZ2wq0kKyivixyzcD+YH03OIVE+OcI6qZkiNKw
	hNaNUeZnVojcm0OLyAgImWB0fjlnfitcXEaSRUsYQKN7amy1XU3oDjUHBaTxi6cgUkB0QKc1SU7
	khI6DFqg1BRDqOYI1z3K6kdiKILACCShx3VexZYtgFWJFQ6+U0QTd7LrQhlOzlylXNPaq
X-Gm-Gg: AR+sD13n/A8QWi1TTr7E/LFTQpWCbkjOniDFt1c+uv3eRngZKtt3UbcO7lfpbN1kxzx
	lEICOVgFx1NzPhnmVA+VLr67az5C90CV/xdwOlixWgU7nrznUGGoW0/s3HZxxQH3kntqB/rOLU6
	/zhLyhNqgAWzrOxBTv4+dyW4sPsreXnnhpsHvNwsOJJ6ixCk6a4Xf4mZae/JlZ2UzIQw5YKn/Ow
	PNdpNra1aQHhGAYcrfeBBAFpv2gkfk5NNuqXBRukJxxnRLXXZZNo6SG6SF+tBbMkty2+1ipAyrk
	ttnYfK34TAIO6sVQ+qL8PBfwPtz4CUN9YZIe7g/Ww3a9jCerDaRxMaqiI86wpHD2iFU1dAPhLgw
	2XEuQRZv+rwEnRryUKcjtWyzClAaBvZ8=
X-Received: by 2002:a17:903:234d:b0:2cc:f4d4:29a7 with SMTP id d9443c01a7336-2cf3499781cmr197604355ad.24.1784631911854;
        Tue, 21 Jul 2026 04:05:11 -0700 (PDT)
X-Received: by 2002:a17:903:234d:b0:2cc:f4d4:29a7 with SMTP id d9443c01a7336-2cf3499781cmr197603705ad.24.1784631911184;
        Tue, 21 Jul 2026 04:05:11 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3471557bsm73364625ad.58.2026.07.21.04.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 04:05:10 -0700 (PDT)
Message-ID: <7b74e6de-fa0f-493c-a159-56bfb0c7de4a@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:35:04 +0530
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] watchdog: pscrr: add watchdog pretimeout reason
 tracking
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Reichel <sre@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Benson Leung
 <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-msm@vger.org, kernel@pengutronix.de,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260714-pscrr-reboot-reason-v1-0-a09f23b12527@oss.qualcomm.com>
 <20260714-pscrr-reboot-reason-v1-2-a09f23b12527@oss.qualcomm.com>
 <5c824be9-59d8-4acb-a2a3-784182ba3c8c@roeck-us.net>
Content-Language: en-US
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
In-Reply-To: <5c824be9-59d8-4acb-a2a3-784182ba3c8c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ojA9A_frYMbev3zF8TA1i-DQfMlgT-8_
X-Authority-Analysis: v=2.4 cv=TIZ1jVla c=1 sm=1 tr=0 ts=6a5f5268 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=xrrK5rgqtf9zyDDYa30A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExNyBTYWx0ZWRfXxWkd271ebjkh
 QbT0t1BzMm9XAx1TM9wnuBcc/6Hq/v3FXFLL8juZeVUBnFrw++8R/bE7SnI++ueaqkmMM4XY6TE
 hcExCbpctf6DeeDHZIXcRirlqk1hUeI=
X-Proofpoint-GUID: ojA9A_frYMbev3zF8TA1i-DQfMlgT-8_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExNyBTYWx0ZWRfXwRs0RkEl/QYC
 DiiyI9/s39TpBfKQ4Iwrj5RSvRJhfp67sc+M0LbZ9jqGFZWx8OFlfAxGUqAre8NMCHDms/mE5Xb
 7tU2t5Foz/oyUoiB+oyHOBHFPlL20XGK0JN7+oXz9e/CNQfSbIVf+RzD7s787F67y3GonthveUs
 QbEvcNwm520VSBQk8F/u9ezwv7oiLCZsEsVtpgbdxZoxXr4m03QnuaNyWrJHQSvNgYvWSH4f/bz
 LAy3yBPwWsHZ1Z9ek3aQZNIdaF0OWgp3/+Fh7rTSjJgtaXr2eJ5iTea/ayVrcZktS2rAzxBQMzx
 Jq6jxeB6sPBGYthkYPQnA0YSARGN7P/T8iTT7naPidqIeZBjRYhYRT+8DeLeomsgEyO/OcF4KAz
 ypCWav7Ug2bT7DUvUm/POhg/6VQK2aTdLtOT/u6AONvu6AAselHiAQrhjl3irhVkGIPqkQeuXDA
 w451u28OxWVz7u9PlqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210117

Hi Guenter,

On 20-Jul-26 10:09 PM, Guenter Roeck wrote:
> On Tue, Jul 14, 2026 at 03:22:35PM +0530, Faruque Ansari wrote:
>> A watchdog pretimeout fires before the actual reset, giving the kernel
>> a brief window to record what happened.  Without this change that
>> window goes unused and the next boot sees PSCR_UNKNOWN, making it
>> impossible to tell a watchdog-driven reset from any other cause.
>>
>> Call set_psc_reason(PSCR_WATCHDOG_PRETIMEOUT) at the top of
>> watchdog_notify_pretimeout() so the reason is recorded as soon as the
>> pretimeout is signalled, before any governor action runs.
>>
>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>> ---
>>   drivers/power/reset/pscrr.c            | 3 ++-
>>   drivers/watchdog/watchdog_pretimeout.c | 3 +++
>>   include/linux/power/power_on_reason.h  | 1 +
>>   include/linux/reboot.h                 | 1 +
>>   kernel/reboot.c                        | 1 +
> 
> This is a cross-subsystem change. As far as I can see it would
> be easy to split it into two patches. Please do that.
> 
> Guenter
> 

Thanks for taking the time to review this.
I'll split into separate PSCRR and watchdog patches in v2.

Thanks,
Faruque Ansari
