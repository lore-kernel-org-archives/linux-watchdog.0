Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828A3E4C92
	for <linux-watchdog@vger.kernel.org>; Wed,  1 Apr 2026 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047492; cv=none; b=lZmKclrp3qslMLtarSCBlSp9Gx0H273NDk0TGqteSQCCIcd/yXr3/NS8oER8oRoCzfsTjEX9xe57T6amx02cw8UBaMBF4/fel8XW8903mfLUzmeqRBAguNjKSipVdCUjgguB5vi1Nu3fuunGNDwGU6trExwoJuDD45CY2PnHqc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047492; c=relaxed/simple;
	bh=PplLofoYYsOeTtzwZzQTOtldU9PgupckQ8Lu+UN/3AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZoZmDGopXYLvoVVKxE3qZEWZhJ7zGB3hT9jwNXcAUj7C1V4sm9JHkY3pnQjclI+e63yvKsVUIHaN6SOLcEiIZC7VqnI8pBCqFEbqpmcUOkov9PilvLj+Fu10weD6EjlLwIHr8oEkOq26U45GMUD/UOf38trwD4wV6SmdI/tMYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PNAVBXLw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WmTy5wJV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PNAVBXLw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WmTy5wJV"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319A8Zv3174206
	for <linux-watchdog@vger.kernel.org>; Wed, 1 Apr 2026 12:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=T/q0fvuVukjPQtBCoPPqM8cPQUhT5omziWM
	9+pyh7R4=; b=PNAVBXLwqcS/lnb2Xh18rDThwqhXYpAAK7bmL/154e9p3TazRJf
	Hactla2CTJZV7cUoD+HmXVC4xvY19rJJkVw1wBNleak6TrtNePKU5M1v3CHC4/aW
	vE5IWbAlChqbYlj6jUeKUCcvMZ8XwC8woUeHmX3kbm4FVqH7eCDw9no6HasyxHL2
	GOXjqboxEeqAaz7Rbu1vuhyISPhdYc7OJ9RnuxzB/1snmtv8P6135TvauHtVFtGG
	3v87FzB49VA2YZv5RKzsQd31lp6VxbX/sxZhbVpJiTs09V5SLCwYMSSpo0ndBbAp
	zbKOVHKVqcUygZGRJaTuFonrWfALJ6RsVCQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d90gbgwfm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-watchdog@vger.kernel.org>; Wed, 01 Apr 2026 12:44:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35678f99c6eso4999480a91.1
        for <linux-watchdog@vger.kernel.org>; Wed, 01 Apr 2026 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775047490; x=1775652290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T/q0fvuVukjPQtBCoPPqM8cPQUhT5omziWM9+pyh7R4=;
        b=WmTy5wJVZ7dRkJMrrZaCtrdEP4cDUlpDbQwr4n8NDT3rpwgYJuB8d1/8uaBQHhl+l5
         PMy2cX4JdShOoNSs41+NcJcFfCgRjXWkXDipyTOA4zn4yCwcv+7IyAkISLiPSTUho9Mc
         +r+kC4gI9lImwMBCJ4i/GEp4BbmOAKc6z8y+SR/U4I7K+kK5smnnsEGPqaedK81nJmjY
         ioCRwEdQFX/X8fJmoItwI5B+YW/JIN/L4FvZDPLVllOOcRGfNlt53FbnqRHAzMQp5r5T
         NepMDW/+PTzw/WkmZtnRDoXojJgntgiHCW3cOXLt8ih8veQKk6rYU1mNve3bg3LljqvZ
         8KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775047490; x=1775652290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/q0fvuVukjPQtBCoPPqM8cPQUhT5omziWM9+pyh7R4=;
        b=BCDIFzrVPoU3dtMNK04DzbzBQbpBdW8OSaYyTlzBV8vN07Fd9tKw/Fcwefpkhck7pI
         ELjg6MVaMA9GN7CL2a8AS67lE4txdfEA5ab0u/UcIrRId+Qv1NZrnOus0cgyfCaAjOke
         gaFFmQiVyh6TcHPwIc+KBwmTatQK5mXF3cRz3t/Ysmw1NsVpORc6IzUuAiJJhYwvGJZY
         Y7O0/9OMLPxyMhkNkhRnyCCJp0xj7bAbvwno4gUzDAdA+lWOUv8l46BkwPK3MTvbavfa
         C0M8zKrufv4A7h2nju6zrpESWs1AyHmVRLMB0QXaQSDMvU5VZOpIhfu1HkFHna+aEJ0f
         Qbrg==
X-Forwarded-Encrypted: i=1; AJvYcCVn+59r3vBdgeUVjk1dDJPikNU7ZNrAhRZuHAYCLvewiQpciKbrDgNjUxw5W7jXsliiAhJRxpPJn8UizHrrhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUcu0oihcs3OgcUNyU+3IChBqt1BUge5Co0BeX9B3IxfSR+Bs+
	NrjIOVzNgtzYCKwO2Usuegu106Gd3vHAz2Z4giOJ8uY0Akk8g8QV3fC9CnGw+9gdIlcqJtcZrq4
	5u0VgS2uR/GEXgs0zjaPPVOUqy1ix6TGqEQYcRLBZ2OF8VbbTERIbysPXBGDiGWBlHIymCQ==
X-Gm-Gg: ATEYQzxPuWKAZjruMB6bvxc5wEDEUcfPtP/EbSDdjSCiYV6QZt7GPSfs1z6FQVTiJI4
	HJA0ln83RtGPM/CBx4YaDrSz5g42itoJPRznD76g6bGfwCq2yvpnGd8zuXlpAY14tlnHMrNbP/L
	rYbo6HATUNyZIdB218jMKpbDFw4dXLjlP+DLzPRy+mbs3xrw5noJBmVw3JdRf4iPwTgiHhf7SY6
	1w5esYOMc2lqCj5LVMAUBI9iQZrmIb1WK+dGWseabbT/ObYJllLsrxfw9HFE57mLSc4kNk+HGgk
	EDXMpiQseqvOAzieCU6yAzoaPyL/g8DS32n2ielcQc6W9y5G60li/snvY0sdoUSq/hRNXsXTTrS
	O51UxnDMgnvS0NWfLignMYJ7HcZmUgxO6phyRNWj/M60ITsu4
X-Received: by 2002:a17:90b:3f8b:b0:35d:a2d3:5c2f with SMTP id 98e67ed59e1d1-35dc701f81amr2917701a91.24.1775047489561;
        Wed, 01 Apr 2026 05:44:49 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8b:b0:35d:a2d3:5c2f with SMTP id 98e67ed59e1d1-35dc701f81amr2917669a91.24.1775047489003;
        Wed, 01 Apr 2026 05:44:49 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe668b24sm4982180a91.8.2026.04.01.05.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:44:48 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: watchdog: qcom-wdt: Document Hawi watchdog compatible
Date: Wed,  1 Apr 2026 18:14:42 +0530
Message-ID: <20260401124442.591803-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDExNSBTYWx0ZWRfXz4iR2jMGCe/G
 Wa9ZaZtVhOwcC5/5BiWb6DUs/GAiJiO3uL9HrndIkbDtGp2g0tww3wMwFT0G2P1eY34439HNNJe
 VcwSV37//iqRCoZnS779DsKyg3Vqoa+Ve+/Vs1HVGIkX5G+UR5CdjKJsTqusCPWc6sCzzvebro+
 SNWE7Bcc0hmH9Dtnv0YVrOARMGhsncmiOVaOcRENxLEJAcC6lKotCOh//9DOiq2O3HksAPohbji
 PxmlSik6Dwuv1lOjZ1B5wvPPTwesLyqknfKfT58I4IljCiJoYdC62OxXTh+aknge0yz6Pzjf+lS
 3IdNyRnQoNgF2hVt3HR7N+XZq8YWwApWj+EIUqVjbYbpV4WIBzA1Wk0nS+8dMV/J/1EBmS+fzys
 Jw/IPsS4TPZqNP9PvX2jrMCcSsc55yEla7bXqNqznMChzFGsdCE06uOm2GMevnDL2LcqUTIxB44
 mfXtW3xKfKE8m2GbqeQ==
X-Authority-Analysis: v=2.4 cv=QJJlhwLL c=1 sm=1 tr=0 ts=69cd1342 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=2XUB28OwWTyWtXMZ7lUA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: TdS1wEElqdQtB87XSzi3rhoY7Qns2m5d
X-Proofpoint-ORIG-GUID: TdS1wEElqdQtB87XSzi3rhoY7Qns2m5d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010115

Add devicetree binding for watchdog present on Qualcomm Hawi SoC.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 9f861045b71e..a8b914d4c06b 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - qcom,apss-wdt-glymur
+              - qcom,apss-wdt-hawi
               - qcom,kpss-wdt-ipq4019
               - qcom,apss-wdt-ipq5018
               - qcom,apss-wdt-ipq5332
-- 
2.53.0

