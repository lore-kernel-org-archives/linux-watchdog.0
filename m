Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41543603EA
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 04:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777953827; cv=none; b=I6w1T72CBAPnJ8ZBgf3H1AkTIUh4q7DcpUX+x9jbJBxALAhSjmZD51Lb9IjUTm5hgqU942737LdNt1urZkCaHrLizLEGi6vNcjZ1YRQD0/ss5jI0gACQxC5JIyRyemyXep4530WyNPKlxGB0eatG3H6LNj2s3B5vnSeXyE08PcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777953827; c=relaxed/simple;
	bh=ZuHj1CaGIwM5CyRrzl4MhNkMttdLsH2fTr5J7/qxBpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNan2qB4zURPnJ/UDG6j8aFODtmNxPk5WGn/zvyzLuxK9pTXNCUixYPOiUzySINqm47N/K2s7pyc2575pBwGmeL/D+E8lwC6Lk57KtYdRLXvXr/4T/k1HDUBo6OKKDgZAR0NJtSXAnn7hXNz5Mht6WAnauw/UNEOdZuYT10Q66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NoJJEZSK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZmANIiB9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NoJJEZSK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZmANIiB9"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644LUWi31960845
	for <linux-watchdog@vger.kernel.org>; Tue, 5 May 2026 04:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DbuCmHz6zfVOe2R0JIVOeIn//8PqSAWi8vGQ7sX9EbI=; b=NoJJEZSKYS/21L1h
	9U1+B6DlAhRN2A3Kz4Z2plpaUVbiZt14/AmcIbWP3gI3ob74h1U7Do9iR7/jLv9u
	eUnuTqJrkZ5/Aro5He2DvI+WPe79YWCtoNj9IpTuC0Pr/Q+4aqRn4hgAHBxMC9V6
	sSgYUo0+f1zq51M8kPVsDlDjafeIw6lIeq3aQmvLPdY94/Dx/ZD5RIuKyDDXf7DV
	eI0BeIsWy4HXUHLvVAlybYre6jQqZMOj0Kp6E2FrsJldY+d3u8AXUkPV2IclTsv/
	f25jqvlFDOQnHUqDozq1XpxeLG0er8wRgEJ/xcDpz+gljb6AUIiouOszv0hnmdBr
	6RbCrA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxw5dtgn6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 04:03:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba224c3ffdso29872625ad.0
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 21:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777953825; x=1778558625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbuCmHz6zfVOe2R0JIVOeIn//8PqSAWi8vGQ7sX9EbI=;
        b=ZmANIiB9JwaVnOGB//8lJcIiQv+m73jO1yS+Nche0qfSxkMAFNPnqrGoi/F5X7qK1X
         w1tNfnrnO11ntCKKRYSGMHuprfaipAsBsbN+PLT6yYN9nG50Hkq5du7orCK263zm/26l
         qUgPdxPq865AMl/C42BdZkbeqRLLlPADU+3k0wTnp9KFfAilyLEEr1GgOLNDsA38G0Zq
         Y0uLN0G6+AHIQUEPwCTqXnT8q/8vMLWsrtaZFGzsIJEZjYLaczJPU4qkTXCqmlgflJFC
         HXsWJ+o5icd5XzvFlLTtdiUi9+yypVldvTSYWX8ys60XM/FQIHuR/KhdcU8z+7+lT3OU
         yRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777953825; x=1778558625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbuCmHz6zfVOe2R0JIVOeIn//8PqSAWi8vGQ7sX9EbI=;
        b=BTXLh+07qO9Zo3VrR1/APee6lSWgcKz6qN7atLBeG+1+F27hn8XX2bnWvvs5+wj5w1
         vv88C7H98TNCQw08fpjRfR8dKqpG2PlUuir3Zd/m+6O4ODc2chS2sA7Hwp3HALC+K3Tk
         87LLilfGeiaHKBgNeSF7bK3XjfCvm6plPTvvbodl85UGe8nTD2VV5MWgKwv1PnPEY84t
         rqpDL7uwFeOMB2VULttL6ss6acA4DhGn/qJhH+rm8Bytz/DgKBAJ3MO25XBYlPD8gVnt
         Kn5oGSoBl1PGATcBobsOdApT8R0VHynbEmos1eAZIZBXDiLaWzr4FdU0xPiISpd3CfHv
         rnRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jAun8lqrLPpva26vo2fgN5Mu9BYvslV3Asngf0QwRHk40PTQ66kaN+P2U2VEtfm8r4hkkQko4cTPZ0/2RCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwARzFo+JGnrsJ4pFnsh8X3qAx1KrZrOH9QAu1laZaA0oUdV77A
	7B0TljF9WVU9zbd464/YjRzaUVf5upWSFeytWkvRGVBAv+3cJR2C9+laOXOfFUXyFveZ3Z4U6fA
	zelAKlSZntNHJYVEluIO70m+jD2jAocC4XAU7p7tyYVfKdjI/h/afqBVpQ6B/DoOg7hoCIfrSGY
	zc4A==
X-Gm-Gg: AeBDies1vSn7YbsH406Uj+Sfayy6iwxuoGWYSDBjQND8bX3rUxMEvxoemfteNQfF45X
	R8RrrbVmLZlSsNf9BIeF+1c+z+tqYnq4yYlKMIINn8sotuBnCkz+nYw0GVtc6J30+rgRAAY7SYr
	LlyomcTwjygWXyDNKq5H1Y77SvTBJ2oodJCoW62IXgkO+QYK6epk7HLAIj6Wy2qM5UENwozhJDt
	AiaKn/fX8PfFu8iWL+Gac27xAjvfoONL1xmf3jaeY+Ql1cDaB9K35x4uxoWfCZiCSodGej1BqDe
	+wbN+gx8KNZVDhCoxvOflzP//OjddhUl/L7So6YY9xhk7qL26kFGTDY+jLk99ffCy7ZVo8tv5Vv
	ij6zx3THBNnw1bI7thBwRGiHPaeybq0ftvbWMVXK1WH8stsSwhF+tVkPgK/WRUYH1GcHxHMB8Sl
	F0Gg==
X-Received: by 2002:a17:903:2385:b0:2b4:62bd:ee3 with SMTP id d9443c01a7336-2ba53883591mr14063085ad.33.1777953825143;
        Mon, 04 May 2026 21:03:45 -0700 (PDT)
X-Received: by 2002:a17:903:2385:b0:2b4:62bd:ee3 with SMTP id d9443c01a7336-2ba53883591mr14062575ad.33.1777953824602;
        Mon, 04 May 2026 21:03:44 -0700 (PDT)
Received: from [10.152.203.161] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa8a0d9sm121090555ad.9.2026.05.04.21.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 21:03:44 -0700 (PDT)
Message-ID: <3f0271d9-3f11-4867-baf2-0ac5747d786b@oss.qualcomm.com>
Date: Tue, 5 May 2026 09:33:38 +0530
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v8 2/2] watchdog: Add driver for Gunyah Watchdog
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260311-gunyah_watchdog-v8-0-4c1c0689de22@oss.qualcomm.com>
 <20260311-gunyah_watchdog-v8-2-4c1c0689de22@oss.qualcomm.com>
 <acqEc_urKggA5s62@baldur> <db85ddc1-b302-45f4-be26-f835c63ef069@quicinc.com>
 <f2386cf2-c790-4ce4-91ab-115a29399e25@roeck-us.net>
 <38fbf5da-abdd-4951-90d2-941f7cd62299@quicinc.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <38fbf5da-abdd-4951-90d2-941f7cd62299@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAzNCBTYWx0ZWRfX8YwW48Gy8wbc
 4jxwGLKfkm+BYgxJlb0lTsMlfzNEeCMO+QicssgikUy2/G1c9g2mCVShasTm6owwVlcHEsn2B+A
 Kgu0c3kz72KwO9evKBXZaq3QT+Pqh3cFCJfY++H/kmvO7/ibyPvf1tV7MiLiwvdhifZCW+10IJ9
 6KKfHFvr+13oe9gIxMLXQrHSAcF0gfcZvpKYO093p77kFq0x/Oi0kUFAmbzrpgLO0Aa55emZ4D3
 Kc7eQQbk5QidLl1RJS891S1g39ZmkQmBAcTQfLz6cb5gkd7UdvKNLBS16dJe2MRjR5duId5xnPd
 1IM9G40yxTttGX2zG713VPFb+zSz7mOihDV9Aks2e8uwbyrZbgxnFAv9Yt6l2PD47mWA7FfMN6a
 0VrOQshIDhuFWFXXFK4M0K3cU9dEO7jpg2Awm+PzDPIcUCkYiASTRdZBU7oQRWnKxk6/eJJMpFZ
 MFArybKWvnZBImng85Q==
X-Proofpoint-GUID: k8d6lu8JT8SenGjTu_jP2nGQD6bP3jvW
X-Proofpoint-ORIG-GUID: k8d6lu8JT8SenGjTu_jP2nGQD6bP3jvW
X-Authority-Analysis: v=2.4 cv=HpJG3UTS c=1 sm=1 tr=0 ts=69f96c22 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=_jlGtV7tAAAA:8
 a=bOwoz5vNKzCG1Xw9MRgA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050034


On 5/5/2026 8:56 AM, Pavan Kondeti wrote:
> On Thu, Apr 30, 2026 at 07:37:12AM -0700, Guenter Roeck wrote:
>> On 4/29/26 23:15, Pavan Kondeti wrote:
>>> On Mon, Mar 30, 2026 at 09:11:48AM -0500, Bjorn Andersson wrote:
>>>> On Wed, Mar 11, 2026 at 11:16:31AM +0530, Pavankumar Kondeti wrote:
>>>>> From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
>>>>>
>>>>> On Qualcomm SoCs running under the Gunyah hypervisor, access to watchdog
>>>>> through MMIO is not available on all platforms. Depending on the
>>>>> hypervisor configuration, the watchdog is either fully emulated or
>>>>> exposed via ARM's SMC Calling Conventions (SMCCC) through the Vendor
>>>>> Specific Hypervisor Service Calls space.
>>>>>
>>>>> Add driver to support the SMC-based watchdog provided by the Gunyah
>>>>> Hypervisor. Device registration is done in the QCOM SCM driver after
>>>>> checks to restrict the watchdog initialization to Qualcomm devices
>>>>> running under Gunyah.
>>>>>
>>>>> Gunyah watchdog is not a hardware but an SMC-based vendor-specific
>>>>> hypervisor interface provided by the Gunyah hypervisor. The design
>>>>> involving QCOM SCM driver for registering the platform device has been
>>>>> devised to avoid adding non-hardware nodes to devicetree.
>>>>>
>>>>> Tested-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>>>>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
>>>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>> Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
>>>>> Signed-off-by: Pavankumar Kondeti <pavan.kondeti@oss.qualcomm.com>
>>>> Guenter, there's no build-time dependency between the two patches. I'm
>>>> applying patch 1 through the qcom tree, please apply this patch through
>>>> the watchdog tree.
>>>>
>>> Thanks Bjorn. I noticed that 1/2 is available in v7.1-rc1 , however 2/2
>>> is missing. Guenter, can you please pick it up for next release?
>>>
>> I don't send watchdog patches upstream; that has always been handled by Wim.
>>
>> Guenter
>>
>>
> Thanks Guenter for the reply.
>
> Wim,
>
> Can you please include this driver (2/2 PATCH) for the next release? Please let us
> know if I need to do anything else?

Pavan,

Please look at the announcement from the Guenter[1] and I see this 
change in the watchdog-next branch of Guenter's tree[2].

[1] 
https://lore.kernel.org/linux-watchdog/cc68acee-484b-4fa5-a3f3-6add81d63d22@oss.qualcomm.com/T/#m11e748ea57c88853b8bdc4e41cac08b7c1cd1b77

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/log/?h=watchdog-next

Thanks,

Kathiravan T.

>
> Thanks,
> Pavan
>
