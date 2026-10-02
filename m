Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072B3B8948
	for <linux-watchdog@vger.kernel.org>; Fri,  2 Oct 2026 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932843; cv=none; b=U47CP6GHdS7ZWiHB09SkjeWH/l4VqT3lmRllH+zO6bu2bxbs+VEiqXrYJeFRB4zvmUf96GoTyPZFIe1ZOl5yECB2r12hs+ZMtpkgTJm/Aqjd/AWLPvbKKtpV45R9B9BO0lM7XkbZYBKBVIx4eaXkLJBWpY768VBbGhs5KI0cH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932843; c=relaxed/simple;
	bh=+HiGs7ic+G67g+jK6ihA8DwHby0KUl5GrLnvv3fDxps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pir/MnDT9w27NlKC7JOBjVOnj8tRifspYU+f7CpQIAQZMzCWY6KsskAWNywjyS+lg7k8aNbZOPl1knKssqs1oMABR4SOFXzC+5TA4DHHskCMPwOeKxYjUyNwuclJ/cHwJmviulP9DKUs+m2bvGc0lkRQgPkVJXp/LRtrUK3U5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RsrDEX8t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KkHk/HYX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RsrDEX8t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KkHk/HYX"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6925jLsL438477
	for <linux-watchdog@vger.kernel.org>; Fri, 2 Oct 2026 09:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BEvD6iYviTx0ERjEtbXW1xNy
	bpDy8Ge//Ongv2RbrMI=; b=RsrDEX8tfSN1k4qR7Mkz/rYSek0nBT/75bonCZIp
	1QTD81buRrzX19IPc1/lX1lQwgla0bPdUhKe1DkPMkYO3xkQ5Js4Ode8N05rH5c8
	GklCBEhQyYD6CjzHxSLoGTIgqMt6Ep8fEjcymTNjtoJFweDAAiLiYXlU4xEl3402
	HmvmO5YiIuGjRZXAeHnsyj2F1S/eL0hwBxopyPAjjKr+hUXwVZ3OVUFA7c8mI4T+
	FMvJAWrorIZaNwd5zvLRFs/nbO51zSQoBlXqYT5G5+baLqYf5q5m/iPUpDoPLNAc
	9Cl96xd3JwGAdlhhh04WiDGBFOUF8TxWMHmX6TlP1Fem2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1sdcku0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 09:20:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb93c874bso262712885a.0
        for <linux-watchdog@vger.kernel.org>; Fri, 02 Oct 2026 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790932839; x=1791537639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BEvD6iYviTx0ERjEtbXW1xNybpDy8Ge//Ongv2RbrMI=;
        b=KkHk/HYXgc6/N+B+dAb7RhFvVn0Ux02I3rAJ60byTGCfQUPxE7pSYVRE709m55WVPv
         5fAjy6eUcbwv5yMo1MixCGJbnWi1Q8qC1PE+84+g5mwYUIA6qVby93N14iJ6IgLGHNmp
         gq29m1nb0ruK4K9HdTfv2zHaG0DH5/Rqr33Q7jepuRgY6avlqBeZKwaQ7OjxfkKq2g06
         q2qLYzW4BXO4WNJ9cdktdUdge5d01F7qXY6XjawO8tvZWihluych8bdbI1YGtglXVVc+
         5Atzimv9OYVWCGN3SxpUjej8gAz6yvEOjK1rZk3mRdmVHtjaLzfjpbyD80OhU6VSwxo3
         LgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932839; x=1791537639;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BEvD6iYviTx0ERjEtbXW1xNybpDy8Ge//Ongv2RbrMI=;
        b=ui0yuvXIICzs4HzFfXMpi7QleWYq1J9QPZKIGmBf6/b/hZS8Nl5cQdlLjcscsffC9z
         9CtUTJ/0i0xCMR4KyBGp+0E9cNc3VO1RwWahPwyYGoSUtRATty2wI/aPB58WC3tdjC/q
         KbYnGwRftbLJuXlecIokodEtu0jeWFqiKTOZtdmtlyiMvhj1Os0diJFoeiGJF5bV0prK
         6fF0AZpuyLJoYXqNQRbTmlMDv9k0zoSG8tOEooXO+x2R1r5tNoO2eL8wi0DS4thzt8WC
         /Dk3uDulAQalJTX8HYs6KqpaS9HWtHRqJzg+yd5TG+bBykYXyKIOi1jDDvEy1GjNR3+/
         7ThA==
X-Forwarded-Encrypted: i=1; AKwUvBzbi1LddHAHIzJbogwqrt426zcicsGHkk25PLoGHRDspoAqBDIE1C4hVA8feLvpbQIM4jy+qF6jAt2VsmR1hg==@vger.kernel.org
X-Gm-Message-State: AFuF++miMYTVUTdPYTsLakP1nx4mVKhwnimkXvvsa3J6mlWFJFyIXbIN
	o5lbo8uWwC+bTG4/ZovG7QIOGVKz6pHHya6hC71B1uv5scUruRpCX99JmF0qV2jdNkr0QdDyWO4
	/DcTY1uWtsVwApKttmI1gxIuDMSfe7J9A40qXHHrcmyi5v0lkKHD+Oe/F7iNuLhY2vr/Llg==
X-Gm-Gg: AYBFou3oK+TyXtzxBIvtx2Nu0PzAE/tesKAsz2hcf12QFJcbPzfKnKfcXwg9lA2Bhj/
	Y2OEmtBG+3hhX4VrYiKVcMd+aDv7dnFakJHTnzzbEJKg8NACG0H752GWHcV/Y3Vp/X18MYmAuB3
	WII/DGrsq34CN3Ax+eaMX5YGM/W++SaSTfxQzlA0Nvf3B7SXWKzM6HWu4v1bHWFEmzhvC+ImclA
	HOG3cheAkaoSj/UvJthVqW1hyfzAfjKPi+9EMdXOxb11VBRjOS6/JpRy22INnKTgTdr5W3qGuCp
	1CJsp1cqIPcB5RX9JBUlhnjJmZHQGhPK1bdjLU2G0qvCce7/0ajh6o5hmnts2Act1OVng80Urmq
	srPQyd/iJpOzYHHg=
X-Received: by 2002:a05:620a:4406:b0:939:c7dc:8712 with SMTP id af79cd13be357-93cb5a5c9d6mr1029732285a.15.1790932838890;
        Fri, 02 Oct 2026 02:20:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4406:b0:939:c7dc:8712 with SMTP id af79cd13be357-93cb5a5c9d6mr1029729585a.15.1790932838313;
        Fri, 02 Oct 2026 02:20:38 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a030326132sm48429645e9.0.2026.10.02.02.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:20:37 -0700 (PDT)
Date: Fri, 2 Oct 2026 12:20:36 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8750: Add watchdog node
Message-ID: <sad5fandsyilvnj5b5huytervp3jfuf57ctfsm5qroxnrvvn6o@d4z3vv6kcwkn>
References: <20260930-sm8750-watchdog-v2-0-b16fcda275d2@oss.qualcomm.com>
 <20260930-sm8750-watchdog-v2-2-b16fcda275d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-sm8750-watchdog-v2-2-b16fcda275d2@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: OM7kJ1kQSNaalxnUkW9wIG_Fm1J63r4f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzNyBTYWx0ZWRfX1h1Ge80t/tve
 jwfH5QokV8TgnEVuQdnbcBjKR7Gx1iE43ZD+7dEMyw5wLHseS4/Cy3rOA6BqwJfe/mCorCxuAh2
 vhXZjlNKKtCB7veuGvMZ88H1FTJIw4E=
X-Proofpoint-GUID: OM7kJ1kQSNaalxnUkW9wIG_Fm1J63r4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzNyBTYWx0ZWRfXweaTYRZtOrIP
 Vx5o0kzzuJBptBdkTt3WmWB4G5hpD0VqjkZf3f/8XyEzJ6oW6ViM1uMHXgpAtYRmjVnf1tu1MyP
 rz5cDa6DqZonT+Es/YlyXYTtHcnqvE2OiWjQdVjogCRwJTUzTGyYFiSZBJj+MZeh+J23R0Hpoh0
 L7VDyaETWelFJqJsbUON9PGdmEAJDr29aFbZfGofQ2a8h+yi9P3wj1ZrjPV7J2ygL/NwjzW6VGs
 Hosh7En64STozMXlIJQhXKfCdOqB0ST+5O69cqTycl9RzWRvCFCk9sCx+yj9q6/b23fR5Y0yDim
 Lj23a8DX07v1qS4ltUdopF5H5bRA1BoYOnbqTO/qz67H4R9rNx43nLZT+9U75M/p4sq4OCE48yd
 dDyLnriaUz7lRMddB1YxIFUdSENDdeAK8fgoo/nANqH+LVMciIH5qFpTeHHz7VS9lsQoSUIaATo
 /nKz0tx4h2nyWzaG/+g==
X-Authority-Analysis: v=2.4 cv=D87SufRj c=1 sm=1 tr=0 ts=6abf7767 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=EiYrS7xXfcF7w+nkr41hpQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=x2DRelJqk6z56t6zBn4A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020037

On 26-09-30 18:32:06, Komal Bajaj wrote:
> Add a node for the watchdog on the SM8750 SoC.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
