Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F91942124F
	for <linux-watchdog@vger.kernel.org>; Wed,  2 Sep 2026 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353110; cv=none; b=Mwlv8AXlPDzk6LGEe/wZZo5dwveUqqlE6m1bF765e0MuD+sYqf92WoOkMhgCWp7EIaNXxkMO4Ss2flIMZGCN5chLj2e+SHiKs+ABmcpz0zasSV9fUxlr+8/0zkp0gBjX02uq/sW6oPTuZM0UjQtg7gJlFH0V3+6Kn2MD1yFgXBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353110; c=relaxed/simple;
	bh=S371zcMUWzIHOFWi/1yKjlfgsvLnkrHmWNy6VFMSzbQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XwJfBbnsAmVGb6D/F8UD7iRr6S/sjqOXI6a+rUb/rX1ZeY7zMo02QRK79O9PVwgHg8idykCkjaLiT0gA7WvZlL5siNR80tblGH6g4DM9nLC0C+J/piJo1kghBYDvJr10lRfVRDZH7ZhwG+lW3n0uLKQPLJImUWiDtxFw405aFnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eFrVYlbs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MEk5z+sX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eFrVYlbs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MEk5z+sX"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CRBrD1549956
	for <linux-watchdog@vger.kernel.org>; Wed, 2 Sep 2026 12:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WVgNOrBJ13icUw/RU5bG9u51U+93bZ1CQveedgfARFk=; b=eFrVYlbsye+dG0bj
	xuXhj4a2MwWtYcr6GMzTvHab30Ae+xutvRqWYx9PN97agXPLM3r8hszQIJxahEwr
	kM5mQ94wfFSncVSTrgWVz1PuGwOqc4D7L/9jgRp4hiTFRXUfnSO5+J+ME1mC5b7U
	Wa6cS937XstGt2eK57+R+xzHhYEKHVdnf/z+S17LUBzPm6iGntpDyrHKvInBtJS6
	OXiw9qOeMeW4+HjEksZ9O512J49MEBK589wJIwCjvJhm5KUJeIh+b3+pKPkHqhs7
	fap6hjmM9KgpvCqfN27hxGih/uBmXorif9X0HncufDqvhkYkNo00qbUXqfHYrEEO
	xVcEtg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gej2c8g76-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 02 Sep 2026 12:45:06 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-85599cf98e5so1900472b3a.1
        for <linux-watchdog@vger.kernel.org>; Wed, 02 Sep 2026 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788353106; x=1788957906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WVgNOrBJ13icUw/RU5bG9u51U+93bZ1CQveedgfARFk=;
        b=MEk5z+sXwdjQXLM/2u7f2PCXwvKOySv2vR30KFAX2U+i/3Y1TfD0I032hMZkB8qNKt
         a0ox8h5cafV+YXFv9Hh7831+kiTpZMUB89+0MHRy5HYLMANiEzsSzRINitD5fD84Omxl
         UhsZgScNnAwiYvQSzY29FVXxxO2PbxC9uwEXhVJ1FGtjDaRMoGgy01ZjxtPsHpbXoSsG
         BJIwYpRfKC/UC5keIwBDFbJqnWUOf2zC3mcYWaX3vqbVRzRWG870yiKK1/5zfoIUUMQ+
         uzJB+PRvZXm9ckMT0UYNy/7N1jNCf7Vxgv8k7KefCImgsmo4NhK3ih1ZgtOShlzhMBvF
         dWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353106; x=1788957906;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WVgNOrBJ13icUw/RU5bG9u51U+93bZ1CQveedgfARFk=;
        b=UcZtqYkZI85VCK1Q+8AysoIvfy43dkGQv0NBbh48mZVW17lN4efsD6Jh8ZeAHgmOEG
         GDUT0XmJA63LN3jLeryhjV/7uAj8me71B196x0ZRBY5pH1Cr5VWEJUKXE8MDNI0EnGY+
         hNASskuBgenZCJSy2irMby6q3hE+8TgIstP1dEmUU82Rrxtr2F8vkiTi5Sfl3QTbHh9u
         vx9t0m48Rc7wcu0Yc7rQAo5m8WXO/438ViBTUh4XsQMS2KkqK/gdjF+TbNte8sH8h8Kx
         f2dP/hrtPrAx0AmQBzQ4R+wTVKAUp+OXJkJxe6IzQzAcbUqr6DqeZGd3+Xu+yxxIHaAf
         g9zg==
X-Forwarded-Encrypted: i=1; AKwUvBzfsuPMFVn42DiyRx6pzNvWxjQc+vLBK7TIQVLaJhBzG58sS44xKCwtWp1dTaTD5Xu8OW+xZgGk05Bdh7u+6g==@vger.kernel.org
X-Gm-Message-State: AFuF++kzgAR2uAlxUVYMnfu4oHWiq4zboMNJpQ5S7iMrQngGB4NvzdFc
	n/nB7Lvfqhgz/oOOmTZhHN4nj2O12n8m9IMQqL+Xuf7z/fjYl+dFkSX72FhglpSuooWggi8odaw
	Lg3pgtFgRrI2ikZD0iMl0AKWeVImq35qUdBZiGCp1J/g4TF2Y5JoaDcL3GrS/OFg/UiDj
X-Gm-Gg: AYBFou2+64t4oHr3lj3UJm4mRoEO8lHcfmw4ByVf+6RyfJwra61hik7vx54wImwdrC9
	2bSRxKuOI6kxQDbSzN38wRCvsrh7j4OoPlldGsMgN7DosxY+BN84d+QKYWAgYFIxnmy1zm0F1JM
	bpXzCCc+8hOYin2DAVx0N/Wni2XjSQVI8LIfYuBXfSsL6WeXON1aCW65Pe1UO50eUD6TR9CvavB
	j4ktO5im13KJ1u4zw0dd7LxXYGneCMmORF81ziA+Kz7RSflzv1dRAGZ26M+Rr87Lz5GTernqxZD
	rZoJzmUx1FhuK8gawoxdaaPcxJfu0B0lCFCQqQmBVm2gmsrHc96g5efgrl/uaK5+m0w19sXCat/
	LIsJXD06Do69RS36sBR4t4BwPpckZuy8=
X-Received: by 2002:a05:6a00:420c:b0:84f:a170:4f5b with SMTP id d2e1a72fcca58-85ed6790ddfmr7638224b3a.8.1788353105883;
        Wed, 02 Sep 2026 05:45:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:420c:b0:84f:a170:4f5b with SMTP id d2e1a72fcca58-85ed6790ddfmr7638098b3a.8.1788353105212;
        Wed, 02 Sep 2026 05:45:05 -0700 (PDT)
Received: from [10.218.33.235] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc003a82bsm1286626b3a.33.2026.09.02.05.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 05:45:04 -0700 (PDT)
Message-ID: <fe6787aa-e15f-4bdf-9004-99eefbf9cc50@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 18:14:55 +0530
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: reset: add PSCRR NVMEM
 recorder binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        =?UTF-8?Q?S=C3=B8ren_Andersen?=
 <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260819-pscrr-provider-v2-0-9072383e0f4d@oss.qualcomm.com>
 <20260819-pscrr-provider-v2-1-9072383e0f4d@oss.qualcomm.com>
 <20260827-spiffy-effective-hare-c05f53@quoll>
Content-Language: en-US
In-Reply-To: <20260827-spiffy-effective-hare-c05f53@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDExMyBTYWx0ZWRfX0452QIpZWqDL
 4F5sJug33+mt7JYoNkS1NNAClo2iYmHBpnvtjZdpMCS9mBOOEHfIH5G30SOf9AXAv1wjbfcdqb1
 Wn1F0W8P0D07roA2/sNBiON/CZqR/gM=
X-Authority-Analysis: v=2.4 cv=G+ss1dk5 c=1 sm=1 tr=0 ts=6a981a52 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=P-IC7800AAAA:8 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=pgIzJ0-J4Cnj9ACx_iUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: YkMOsxPqhKjAjow3C2_RjDaJ5-JHMExe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDExMyBTYWx0ZWRfX10E72Y7gW/bM
 kK/d2AwErf5bGOPtj4kgfen3u8Jfqun/w0Q3jhFgwa1fn7RocMoEAAKXpMGTvWSLf6z2KqBKo7f
 5A/4GdyEcCHf/k00ZydaRVRmvWKFrwLZeWtXeemTn06ofxiMZlPntgos1zUA+8IDZ16HohHw8WE
 kWcFwJwIfXbPwXdNNXfdiLSl+M8H+ZBX3I2ie1PXIUwzgtxZpxNkf60F6NqyBjrdCR/LXnkAGhA
 TXPWqUoTd2HBc2FojqmNZXEITiKP3K3WTH9zrfZhLy0QHQ2eFhP5EiLwnaD9oaL4xyp5K5M159z
 Bkj55dqr3znapte/c0TBcHjDBJ7chPYADBkL+pqBnvOelQoTLRdFZ77/ZKxbCFhRR4avjdJLuSP
 2hBl+YF74+LNzFGXO0p37X8Yk7QP5dSubMxVaQ46wLtwZZuQmSP0P/8Ai0yTPxwFosoHew58cuG
 fFfs4jTP1g/MTpE+5fg==
X-Proofpoint-ORIG-GUID: YkMOsxPqhKjAjow3C2_RjDaJ5-JHMExe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020113


Hi Krzysztof,

On 27-Aug-26 3:15 PM, Krzysztof Kozlowski wrote:
> On Wed, Aug 19, 2026 at 10:50:43PM +0530, Faruque Ansari wrote:
>> Add binding for the PSCRR NVMEM recorder. Records the power state
>> change reason into a small NVMEM cell, such as a PMIC SDAM byte or
>> RTC scratch register — so the cause survives a power cycle and can be
>> read back on the next boot.
> 
> A nit, subject: drop second/last, redundant "binding". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23
> 
Thanks for the review.
I'll fix this in V3.

>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>> ---
>>   .../bindings/power/reset/pscrr-nvmem.yaml          | 59 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  1 +
>>   2 files changed, 60 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml b/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml
>> new file mode 100644
>> index 000000000000..5334c923d644
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/reset/pscrr-nvmem.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NVMEM Power State Change Reason recorder
>> +
>> +maintainers:
>> +  - Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>> +  - Oleksij Rempel <o.rempel@pengutronix.de>
>> +
>> +description:
>> +  An NVMEM-backed recorder for Power State Change Reasons (PSCRR). Persists
>> +  the reboot or shutdown cause into a small NVMEM cell, such as an RTC
>> +  scratch register, a PMIC SDAM (Scratch Data Access Memory) byte, or an
>> +  EEPROM — so the reason survives a power cycle and can be read back on the
>> +  next boot. The cell is referenced via the standard nvmem-cells consumer
>> +  binding.
> 
> I do not see how this should be a separate device. This should be rather part
> of PSCRR, reboot handler or just the nvmem. Otherwise it is just device
> node for instantiating driver.

There's already precedent in-tree for exactly this shape of 
binding: 
Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml 
defines a standalone "nvmem-reboot-mode" compatible whose sole 
purpose is to bind an nvmem-cell and instantiate a driver that 
writes a reboot-mode value into it before reset, for the 
bootloader to read.

pscrr-nvmem follows the same pattern: instead of a reboot-mode 
value for the bootloader, it records the PSCRR reason into an 
NVMEM cell before reset and reads it back on the next boot for 
PSCRR to report. Like nvmem-reboot-mode, it works with any NVMEM 
backend (RTC scratch register, PMIC SDAM, EEPROM, etc.).

It doesn't fit cleanly into PSCRR core (hardware-agnostic, no 
NVMEM dependency today) or a specific reset handler (it only 
records the reason, it doesn't initiate the reset).


Thanks,
Faruque Ansari
