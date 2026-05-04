Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4123DE43C
	for <linux-watchdog@vger.kernel.org>; Mon,  4 May 2026 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904971; cv=none; b=m6olMsZoSUOQue7Kro6C8za42dA7Pfl+zowH96yMUf33RYBn/tbnauzdYBc0xpbiZeEPolMXx8fb1FQtJQSSdSNo8EoQfemNVC36czD8RITM7k7HBMdYcKBbT/49PHS9RNUoT2s06G5YUerYMWpW7uQry8NHE79Rn3gt81QjIj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904971; c=relaxed/simple;
	bh=dWQ+7g3S1vkKi5exFH5eRfGqKEbzwCAAwUQnQ6WQXj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juETA+2y0BEuHbQLVpeBtFzUvc1iPjW/Bf3UwXtOp+Deoz7eCBEy5LQVqtUwkodmSrhHBL8IBUKzTy+WTa1B78DssttrlRYb4a0QQGYZVYg7gjM0tnN4kTxWScthwNvXpu0cdEs99+AP9FFpEqUST6p9AaronEiCuAC5Br51iUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XxQjOYo1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GxtheN6z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XxQjOYo1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GxtheN6z"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644B479Z749094
	for <linux-watchdog@vger.kernel.org>; Mon, 4 May 2026 14:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SIZcF0jLrnQngCTAarVexF6PhV4RPMhWxFIRRYZbq/8=; b=XxQjOYo1irc8hXeO
	SfO/1LDZbmq7/R2SNtNb6AzTpHzBZPtJ+9iuzVmSH2x3FT/sTdA99xAzJsnlXeE0
	sMTRt3o8UtclkpHgAPLNdCqe5vUbG9XaDNSTK0OMLmYwa0Fyhbjoszk1PW2bNOvp
	+OkoV8KQ8Sq8kRk3UPEL//HZ7ok4TsomQ+mmIEiAN7poMAaWW8Ot2Oa483YK1UAT
	J0UNtRL+OU4xNgssXR2EgFNf4y3hGMvRAgOny/36/ZSk7ZKwRPjo1p9kyTMUkOtg
	6a7P6HzUIpprsQfkwcFkmgIw/FHF7NAnhJi8NjODEHKewXJocW2yypDExviff/gc
	7/FcZw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxscf0srw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 14:29:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so1928027a12.0
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777904967; x=1778509767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIZcF0jLrnQngCTAarVexF6PhV4RPMhWxFIRRYZbq/8=;
        b=GxtheN6zJbgV7i68uYlG+j7X2wBZbiWgkm/SdBpHsRpvbc5FInPW3/yMZIf+JMMamT
         rZUvpljaSP+z2iqLbG/jz8r5/DYKy2v+fpC73/ha6pWdb1nFVmS1iuOoZVU5uWUwz2U9
         Bd7AIptDmFF/JzerA5O5yfLGs6++bgspU5q8uqvS4enSL/CUebCaG1IRX6B29Wp4eJfY
         qbrEdQX5IL2Sr3rfJicO5oiHSgpVxGi6YOgipYo5zb4BvoSPSfRuT4eJI3qyHqRLpTM5
         U0o3jiFaFHq08mYznXRtmBuK3biOQbsRlwCRlrI1jkQC5EnpDcC/Q89Adh+z57+cySJk
         CS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777904967; x=1778509767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIZcF0jLrnQngCTAarVexF6PhV4RPMhWxFIRRYZbq/8=;
        b=eT5dzsliyZaXwTCyaZll7/J2dIj7NR9VUEGz8bf4BWl0ZWaQO/owp2ukwv7GehTspm
         dyXgMzPNT1OrdJT+r1R7uR4W59m/9P9L+XeREyITBCTUYo09YFispFc/nPBq9GB6nBBS
         +w+bF+RYbfZdqQYCquiGMg3nVO9OomWb33zgUYjybOiinFEkSn8riOlkSItfFpp4t8Y9
         be8dDGLsF5akMsRQyzBuZqe9wM+bneLG3URRQ8kd7u/O9sXp9dcATPXl/qUlauL8rJeX
         EGCA09Qr2OS4HvjLhjO1zIT5NpzJ8FWjMtu5g5lffNeM9NxbSnnkIFmXbCKXCl4dwaUx
         qSVw==
X-Forwarded-Encrypted: i=1; AFNElJ+4Y12L7rDmgIOY9Ju0xcXReAB4ya2L2To9gfUA7wbOo4vb5S0FTg1mNcBZ9O0Cwm9zyv8f1bsT6EW69BQniA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2JhdXEc66mcI2At9sCRdQZEElXQZqRvE5breo/bDlNImsVzUM
	OeL7R9qsE/FgtESgUO7GTK4oXR6TKujd3DVYiaJG6FtbJ4A8E52r+r46XQa4niTeqHY8NvSB4ZV
	vwdNUrDDAPoFgACAdLRvGcGHPBUb9X4RARQLpEeF4rhAaLlfZRxAVXzjE+hbAuK1rMHcLIKib87
	5L7Q==
X-Gm-Gg: AeBDietA7xJ5mCcg9zb+xnes5G5hrQyi2tm+O5EJpf67CVITxerpcwOgdzuW4qt+zzE
	V0o7QYdg1hk+J9nAIj6T8cA82kCR/B2cdC/KnxQu1EWeeGTUZ9NaNTfey+xx1yw1JYiPS002TPA
	7E3gbsIJzeUgY+Hc+wXZpMQMD1b58TxWUXCK5GPi4JCKcBIEyTFwfgenUMR+IamuKPWqPXgGYWT
	MuQE0v2GNGilaYhqtWsqvRpk2bnQKBydAQ3vo4zkStxQaxkgY8LOJ/uUTrhUDOxoDF+O5GUlIhy
	9kbPs+YJzVvNJkplEGqO+tKxr3AtEFbZqs19e5c4lK2+vJwNFHgcu1sPsQMoe2Uj2kyUa8F9Kjo
	ara+s8YoeB5KfEL8anCLqzwppISjTHQII+zil+gi5fuZaL+H7kIu5nQwPSf/eAu5kUniuXJb1Ln
	ZR
X-Received: by 2002:a05:6a20:3d05:b0:38e:92f6:9ab1 with SMTP id adf61e73a8af0-3a7f03c6f0emr8313250637.22.1777904967382;
        Mon, 04 May 2026 07:29:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d05:b0:38e:92f6:9ab1 with SMTP id adf61e73a8af0-3a7f03c6f0emr8313206637.22.1777904966680;
        Mon, 04 May 2026 07:29:26 -0700 (PDT)
Received: from [192.168.1.6] ([122.164.84.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbbbf298sm10054114a12.13.2026.05.04.07.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 07:29:26 -0700 (PDT)
Message-ID: <cc68acee-484b-4fa5-a3f3-6add81d63d22@oss.qualcomm.com>
Date: Mon, 4 May 2026 19:59:22 +0530
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Picking up watchdog pull requests starting with the 7.2 commit
 window
To: Guenter Roeck <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <2ca2a562-f9b6-4a68-a3a6-1fe4c03e7b40@roeck-us.net>
 <b1309b89-ffe6-4b6b-b257-bf7d7b8f5885@oss.qualcomm.com>
 <1fc146d7-04e4-4dff-92b5-e6dcb81eabeb@roeck-us.net>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <1fc146d7-04e4-4dff-92b5-e6dcb81eabeb@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BcvoFLt2 c=1 sm=1 tr=0 ts=69f8ad48 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=/mHg5lR1HfVRp+Rzqux+Iw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=ris02UWNMwmQM3wLqugA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1MCBTYWx0ZWRfX6tXsckX01yYB
 xMCB2Gjm97C8jI2M4jTZIm1fFqsCVwVX5ihLLiJNAW2eu2b2rttsGhkpsj1dPBBrVm93eClFWB9
 JGgp1dDScDqMEJWkNJMYI5ctQD43gcg8LVb46X1GT8lcb1v2OAw5uOLdLi8IYZb0lIwlNjssSkO
 1Xp+lQ4QAAtgIQ5/CDnct2IsYhq/GkBWsSGpgdK6MaKQZjOvm5Ln6nptO8oTem86uRJ+klorSK6
 pnagoWqNK4dDWyuxwsyyZxDJmXfBfLIxqGL+dxY0Qzfz/nIskat2BgrMCccT1gVRa/RUV5mg53U
 NSlqPXK3U1MIK8fiUs7gBmIwdq6Jrzn73nxyOa1SJVanh1XtSnVxOH7YK7zfpmu2wAor5Rz1pbp
 KCW2JdN41K2HuVJ+ZW21wFJBt3CaWiOzBAwVi7LWec4pUQY2F+vUA7g5lzQ5LjqvICRoU34lCoa
 BdVbtWUnkiq16IEfp+g==
X-Proofpoint-ORIG-GUID: FcDQg7ZdgsFn3WePzxYTy7f4DV8FkV1a
X-Proofpoint-GUID: FcDQg7ZdgsFn3WePzxYTy7f4DV8FkV1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040150


On 5/4/2026 7:06 PM, Guenter Roeck wrote:
> On 5/4/26 02:58, Kathiravan Thirumoorthy wrote:
>>
>> On 5/3/2026 10:10 PM, Guenter Roeck wrote:
>>> Hi all,
>>>
>>> I have not heard from Wim recently, and he did not send a watchdog
>>> pull request for the 7.1 commit window.
>>>
>>> Unless Wim informs me that this was an exception and that he will
>>> continue sending pull requests going forward, I'll handle watchdog
>>> subsystem pull requests starting with the 7.2 commit window.
>>
>> Thanks Guenter. Curious to know - will your branch[1] be integrated 
>> into the linux-next as well?
>>
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/log/?h=watchdog-next
>>
> Yes, if I don't hear from Wim in a week or so.
>
Thanks for the information, Guenter!.

> Guenter
>
