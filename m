Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069224CE67E
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771822; cv=none; b=VM8olqX0GQyMauCjSR4ERvSd5aWAQ5O2vqT3gKgRRGO5J51lyvCpCATZWmFEUY3yg4QXtThbk2naSOPcHX2EByQOCKzDkfJOWmYIf24EXMdnZDtEBbLrqvMmSJo51UJKCu5a4oqXOLOWCR8Nemd0rmUln6uWtZN+bD8XaiorN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771822; c=relaxed/simple;
	bh=u3FP4394F5WeOzXMgeTc0izd67r1yUkSSChegsp9gSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFIzr72LdpVksK0bVDIt+X9gYY29qeoLFpTL8jTdGtc9K2owhhirPi00AtlvuMk4cH9EkddVKTMqpjyfKt9Vte/sQ3SPaGinpRl2n5PBKdq1htL6IGLXMseZui1pe5XmwsCBzl1lwWKfk8RfO71Qzpc9aegw7nVmNc8jIf/ZShY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jp+OC0ff; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f9j6Wyy5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jp+OC0ff";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f9j6Wyy5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UB7haU2584078
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 12:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YR1pxcm93dXVjoCVwNe8cAwUkjwrpYKoF5JTMsrsvYY=; b=Jp+OC0ffgWmb05Ok
	DwUbVD9KvFLD9T8wCmeGszFRIvkgwyugnGTdMgN6n+LRmI/eNd6OjPtFZ8aS2Ek+
	/s5ebp9fDmYtbvxfWvbUpjEWGNo1n36FVwM5n/g8KCYkfF0J+Q+qYLQdpB/nQtNg
	Cf8EPmlfTqS6H9iKeqvI7gx7yb4+g4gqn7kQyMt8yrlBVGZiqeReYU/pSpjBnNAm
	bgn3+yqg31O25MKFTjuDICrMnkqDuGKnqVAHQQ+Bd0DvxgFZ26MZ31GTUJEn7buU
	AA/fkt2liss00X+yNA2DnXpYSzPUlIY8KelGr6AaHVTqcgH7LwOnMpWKy753w7eh
	XrakFw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rhejt4h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 12:36:52 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86261e66700so3972833b3a.3
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 05:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790771744; x=1791376544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YR1pxcm93dXVjoCVwNe8cAwUkjwrpYKoF5JTMsrsvYY=;
        b=f9j6Wyy52CzGLfz7QBdPHqAxQHTAwVnEzSVMws4OMSaZ3khlQmLtoYVVTM9r553feP
         NaF0bTgd16cx3QUPfV0VrpgOKScXFwmlc+byO6oUcXHTuvpVmsBJELhQjjtcbJt0t9OD
         ZTHmPCrEdnAYDWwHhR4iwOSwXDtl28RnmXuyeGN6vHh9CKIa15YSL0cjQq7ZBDQprEP4
         loQhDl1Iklvwocgop1JHwRTvmZTEI33zAeBOjR2oo8jWJpjwByZiM9Of82tI0wDKde7T
         GeOZdk9Eu3QUd+6TIfgDjA24eS0XlPsXkN3eoYVf/72DPiGh4jl2Air6iwxnzwtxAOEk
         C1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790771744; x=1791376544;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YR1pxcm93dXVjoCVwNe8cAwUkjwrpYKoF5JTMsrsvYY=;
        b=A1jlU6zHnNWDR1/xICEqILre5UYu5jIHeyp/W0en06iIQwt/WYI3+XYPuZ58n4ILWh
         0WQTWI5G8IAHjuHLdsE+4iOYsFdoeqDomfGwPyCVrLw75wxbeooSlrrWN1E0+jEVxb69
         geGklEYhL5OyqT4VABVbrANxmiIHc3BKQmBxgMgGni6vLhxWpZPD5i1Ha/uvgCygGGtL
         XcGzOyix+UVjSGy3xt1KA4A2VgSNapyCZh+xhBt2VQCsJlL47Vvw5sfVjXjzvTbUM/Em
         m8Eiwg8XAa0YKljx/u6OQg34DsVHCHXgbyxqR/M95c9aHixB4S6Iafgt5Q+EsMQMKNHm
         PMfw==
X-Forwarded-Encrypted: i=1; AKwUvBwctdp/Cxwt4dTbipDVO+jCkM6A8bOvrduHX7F1yWvVl30A4s0wiTGxMoPj+gCEfN3jfjiN4fiKJshcpnu4yQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m4SyVm9yA83ZOotKQLdoeOln9pxRj5a8cVGQNbM9nqfQApHajg
	/dOtaRbPjW1VCUzitBzq4ZM2XFfXZZKonwiozU9A0bfAb+GaInSkJF2KhnIzMLNkbH4SELLvefr
	7Pdx0HtGftJ9wJ31oIl7QxqCPZO7S4FbDKz/zeXOIOgZ7IJhHRlrM4HNeGgXmy73ngGgbDA==
X-Gm-Gg: AYBFou1eT0IdTgihV/LrcaeTgpb3AA0ilOGw+pY5my8MHRZW7Cbr8GfIRZoxBIlB89C
	J8tTDWxrTA9K8BT5mGqreOrJ3ODa9pos40rSxSYmoc5Mxup47F8Yhow89rLDFOi7XLeoUwc4yn6
	8yFe7KAhgcwqhFvlqlSXI1xK/HCnPkvL8DyYsfJ7a7RQuHout+hLFXyZUmt2m2Yb6sGzEzFzcZc
	cJ0u3EbsnuuqL4Os1ir0QnikuIMsP9aoFV+j6p4cy4NycgEldzjxvai9BRcIBKUjN5VbER7F/p/
	ypPibjtkquSy/9gSpGCQFmZGX+T+c9HkbJiLpAVMV2ZEPsr8UE4FSfvipGFLGqF2VJa16V+C+4a
	02jwCGKzZnEcqj06op70vJIaHB9A=
X-Received: by 2002:a05:6a00:4188:b0:871:aee:8b92 with SMTP id d2e1a72fcca58-8874a89aa56mr1031251b3a.15.1790771744338;
        Wed, 30 Sep 2026 05:35:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:4188:b0:871:aee:8b92 with SMTP id d2e1a72fcca58-8874a89aa56mr1031231b3a.15.1790771743825;
        Wed, 30 Sep 2026 05:35:43 -0700 (PDT)
Received: from [10.218.30.203] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887bc2bd76asm114029b3a.48.2026.09.30.05.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 05:35:43 -0700 (PDT)
Message-ID: <ab83f7d1-7165-47f3-afcd-6574ef5d9238@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:05:40 +0530
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8750: Add watchdog node
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20260929-sm8750-watchdog-v1-0-ea06d5dc7e54@oss.qualcomm.com>
 <20260929-sm8750-watchdog-v1-2-ea06d5dc7e54@oss.qualcomm.com>
 <20260929103912.C22291F00893@smtp.kernel.org>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <20260929103912.C22291F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: B3tgDHKfm2dE1U_h304fr8rwvSJW5aQL
X-Proofpoint-ORIG-GUID: B3tgDHKfm2dE1U_h304fr8rwvSJW5aQL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1MCBTYWx0ZWRfXy1qHOngQ5LP+
 ZsE3LGDtrVN5+GDB7KuYg0VQU297qORtDDkrgzehAMxELrgZzikx8X04ghyk6lG44QdCvar1uuw
 iHR26FLzug5SFWr1W9UQ36nXTiKkz6pweb8HUtWxCyO1tXqMv+KoeXNw1GDvE9REMLlNZ1GCSLE
 lwTbXWc31MnduomQqTvTA3eCDPyX2kuhfiJxdbb41qfORBEY3XqsWsY4fXfP3Y79zJ1LYXUXfKh
 OPxM6uXp+24m1sruTP/GlCbgd3nFJ1NmrTXSiSmetMHP0pnbRccF3nint1ha/z8mH/vaVCXpjxB
 Z9dmyPWwpqt4XpY55kH1H1iRYOhXY+VWp86xmGfofRrJ7I1F4zqsoxVoki8JHlX/XrJ0gnSzNXm
 s6vD+SkcUylPNNWJZP2LkQU11n7RC+/SzbNP0D/4f4Q34kR3n4lIMzqIUMd28R9nu7rh4AP8Q2f
 cubyH53Iy3rK6rSAleA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1MCBTYWx0ZWRfX+6tkJgjBhy/L
 BWyF0yIa6i5kZkFToBYCt9sKCm0S24hp9U6fmNkVbLtmQK5cfP6LE8voj6GKLS/SOAEiSHvCJYJ
 GqO1mMCerehTPn6a+Yizjx9bwOC+X1s=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abd026a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=z0PHE49TrWTsZCah-ZsA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300050

On 9/29/2026 4:09 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] dt: incorrect node ordering in sm8750.dtsi
> --
>
> commit 807aba78b66c219c014d5a42b4b7964dbeb6b207
> Author: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>
> arm64: dts: qcom: sm8750: Add watchdog node
>      
> This commit adds a device tree node for the watchdog on the SM8750 SoC.
>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> index 8ed5fa4d24fcd..53125e5dc4cca 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> @@ -6006,6 +6006,13 @@ cpucp_mbox: mailbox@16430000 {
>>   			#mbox-cells = <1>;
>>   		};
>>   
>> +		watchdog@16410000 {
>> +			compatible = "qcom,apss-wdt-sm8750", "qcom,kpss-wdt";
>> +			reg = <0x0 0x16410000 0x0 0x1000>;
>> +			clocks = <&sleep_clk>;
>> +			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
>> +		};
>> +
> [Severity: Low]
> Does this placement break the ascending unit-address order convention for
> Device Tree files?
>
> The new watchdog@16410000 node is being placed immediately after the
> mailbox@16430000 node. Should this node be moved above the mailbox node to
> keep the children sorted numerically by their unit address?

I missed that. I will fix the node ordering in next version.

Thanks
Komal

>
>>   		apps_rsc: rsc@16500000 {
>>   			compatible = "qcom,rpmh-rsc";
>>   			reg = <0x0 0x16500000 0x0 0x10000>,

