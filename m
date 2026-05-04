Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2238C2A8
	for <linux-watchdog@vger.kernel.org>; Mon,  4 May 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888737; cv=none; b=nqa/w51F7tpzvDrovHZdP8tMLzODOIHaovRE7UTJlHr11x8hggsff8ZAZkPA90iKYhniFGhpDCS9jF6GJEofLJK7Lc3jqIswKzWDXVP2hjNKMXCy0h+0XA8H1etZlG4hCExXuWektIsVOBJ90H4zPo1z9LgQEPzGumJMN0EvGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888737; c=relaxed/simple;
	bh=a1orELRvHY8qWotfN0H+UJ7yTgDZ/ih56SO7Y/jQoLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJlrgqoT72mIQDrwQ+FJ7ICGY+VtdUmm3Ef9hNS+Gk4FiIXoCb9FDJkhMWTmfAWhe9rIMvTGjBGHSZwIFMqL+c4KPLoZsdmKjcjC7Dm185QPdGFlSE08wI4PiATIWKF2zhPd7AKwUklDdfc4iQz296z3IbwLwtEoNi2IQq22j7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TZ3NZhQH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MljZuLc/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TZ3NZhQH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MljZuLc/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6448fTKV1219033
	for <linux-watchdog@vger.kernel.org>; Mon, 4 May 2026 09:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I/nj+6++Ve4YaI22LC5C5Jai3fjpOWc0MUgjFBIApLU=; b=TZ3NZhQHv6SJVe5X
	iOlT/f0uTeYDvf856fPwWfA0nnYet/Uq6v3KiTUZ6tsi5ICUtfup0N5jGusAtnaV
	HenCSnfmRyxZr+E8qBdRZHz/tBSpn1QleSlfZ44qvkbliUBWKpncSwVrn+/va5+I
	OoAfdPBqp9ZR+ASVT/uRZQf/HB41g/eemPWOXCqgTZfi1n7HAOyJ3paHLYPqXqbO
	c96sZBjJvFxqNOMasgLBp7u/sPAWECjTFu7sn2AD8x/mmVv3vi7OJcry663V5ujH
	XhWlLOV8MYM5/icBZ2C0duZDslw/94KEB0Zq2dQzjc6RyvsOAauzpK+HQa1bSkCp
	5vJs2g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwa1en56a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 09:58:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aad5fec175so52898405ad.2
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777888735; x=1778493535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/nj+6++Ve4YaI22LC5C5Jai3fjpOWc0MUgjFBIApLU=;
        b=MljZuLc/8TUOrzEcLnxkT3p4j2acEofybG26cvC5OuI1+9cUIxbWnDMVYLZ0PVbkAq
         l4zQUMGvDKw3YMLchH1JrxOLFtwCrw/5dqUgHpSbls4771jj2WRvN1obFh/a0j+5/LYC
         9XOWlGNFt5/lC85nkLGM0G4ULmrGs6xKDBcd9ou3TSbFUcvIECnq+jH/P3prIBQcRXDb
         3nNKie5kT45D1jrjlLHssEP0MRNzD2B48jeDZRwPYuQjtBkUfEmpG49szxjwTPwzC5FL
         UAWDmEjx5WkvdFTZ3/WNssyI8JQ5jXRs/xPq6A5+Z52WdF3aS5ChFrz+bfgTiWpPPIQX
         1TJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777888735; x=1778493535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/nj+6++Ve4YaI22LC5C5Jai3fjpOWc0MUgjFBIApLU=;
        b=RwrliDuSMhWhzePaqDpapXCOJc44cZ/qIiA7luR+wbOgLED5V5rz/F6bGkwpE3fwvc
         vqJU/ikM+kFhes4ysUNBJsSdwBYAn1nNCl1+pGrOgzYGnplr6glgmkyjmgN+yKVYpFGI
         fK6pweSVXWSJ7EoBllhgNNc9Wdl/IBYwOPuoi5b3qqo+DTtI9i6rO8lQkS7dlA3vl90n
         6ODzCJFai5wagaDXELk1CCC3Wl2RP5d0Mv5Ka7aXefzvJTH2cA7ajsTblpNpHUhgDWbn
         K3T3ztSr85iCGJkQkLtOPx438roS2qOld++WdUAFlNz76xjvEULZS4MNqezzZpdoLRLY
         pRww==
X-Forwarded-Encrypted: i=1; AFNElJ98V0xBkn2QxoYXUFpeXHEcas53ZTzr4EQBpaqRHWR6pJRp8/rYJfnvzzJ4/VeKEeUjINlQB3ZedINo4sZZkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7NTU21goqMOJH/+FhAxIIW2Ze2CuS9b9rJozOEasd44jQ1Hup
	DYSccdTrOSKX8MQTjSUGjeCS7rruCFU5puB0OpzP+acL72lsrxzI5W5vBF6dOofJ4ugpRlALu34
	ZLYk74LomeqAczRzfz5SjBfhlk4Lbd/3VmPDNYt/MlEzyDpFM0aPSdPyOhW34dANl2+vX2uZMno
	Qr2A==
X-Gm-Gg: AeBDietcSt3rqhD3KKZtKfkPrwWrnujLxQg9jWpy+phikp/45wTHEapEsYEXWurOBtM
	XQ5h5UsaFVIBvcecidF2tFtLoZGCcYt+gkOZINTOAVbwBslWoqb3RHlEf7cbnHZvkb+plI0rVoI
	1i4ecpJKnODmL6drbcl4jTCCf16f4CbnXPjgumheWvV8+zobW+HKMhZdKfwZXM2fNEmhBawYmwV
	k7VE7GJEqRPdjUkZyw8NF8MoBtw/4iOyQahxUf22U1rzY6nfyCiRT162RXZTIc2C4qomN8IRG6k
	3Jxy3WIlzkSGIVqUtiGrjS0LyUoIH5n4w2P+aQ9b1wUTqFLcFD2AH3WD8erzhqMP9WrtBwdjmqn
	6y7k9R9O5uVOCiYNdS2GF2ud00eNeTfLc9PP2kCLwHDvJI9gXIxPH1o2bI7/BZIcBU7w/SZ1BvU
	uk
X-Received: by 2002:a17:902:cad4:b0:2b4:5893:3f3c with SMTP id d9443c01a7336-2b9f256ba6emr54352105ad.13.1777888735000;
        Mon, 04 May 2026 02:58:55 -0700 (PDT)
X-Received: by 2002:a17:902:cad4:b0:2b4:5893:3f3c with SMTP id d9443c01a7336-2b9f256ba6emr54351975ad.13.1777888734559;
        Mon, 04 May 2026 02:58:54 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0f6d8sm99381025ad.39.2026.05.04.02.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 02:58:54 -0700 (PDT)
Message-ID: <b1309b89-ffe6-4b6b-b257-bf7d7b8f5885@oss.qualcomm.com>
Date: Mon, 4 May 2026 15:28:50 +0530
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
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <2ca2a562-f9b6-4a68-a3a6-1fe4c03e7b40@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: e5oJC6DKeF5NwsLlaLrpT3LbbqVlDjFF
X-Proofpoint-GUID: e5oJC6DKeF5NwsLlaLrpT3LbbqVlDjFF
X-Authority-Analysis: v=2.4 cv=e7U2j6p/ c=1 sm=1 tr=0 ts=69f86de0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=CHOsQhHtM85WiQWe0J0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwNSBTYWx0ZWRfX5njFdEzivJYY
 uoEOTXa/xyJA2Z+8yreVS7OtT1IzPCEAirC4uqxhVrndFNBJFy4A0DUlop8RTcam0tKfHOr+q90
 RaBGszVFcj5kT+DEYeqOH1uuWoq9Kwae4Abw+OFzSKeQoIR5XLSKXf/tMqiJJ9fFhbp7uxxtcwp
 WynL2oBgi0JsWqIFycR8H4HS+pjYWorJSS3nAxshESisZZt8rSsqBWbdOcDKpcYMa6Rx+0aN1iY
 RpOLVDJBfsRuYVziUdD/7re/cRPzikBYHFNpcqA4rx4rXIyrO0Lf0lvFS5CRcy624caJ9lfIOd/
 gwd+0u5DqKztg07lj5YwENryyh4LhX8GRS2LYL2d+Cq8Eg/ftQp1XORzBeuIfCeFYbdr3oqIU+P
 babom5Z4t8A6dOtahz/2a5UZYpqaiyCzIaGpKcf7ut4K5kGHxJmTbXkzXFJC4GEjc3yCNMxYc+H
 AqIgnrbH8FR5MO4odGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040105


On 5/3/2026 10:10 PM, Guenter Roeck wrote:
> Hi all,
>
> I have not heard from Wim recently, and he did not send a watchdog
> pull request for the 7.1 commit window.
>
> Unless Wim informs me that this was an exception and that he will
> continue sending pull requests going forward, I'll handle watchdog
> subsystem pull requests starting with the 7.2 commit window.

Thanks Guenter. Curious to know - will your branch[1] be integrated into 
the linux-next as well?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/log/?h=watchdog-next

>
> Thanks,
> Guenter
>
>
