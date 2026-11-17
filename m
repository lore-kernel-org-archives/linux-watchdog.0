Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906602;
	b=slohj6lRDhp9/wdX2/4/hFGrZF3S7Q7O3bfTAL49moH8+1qThvrFW4HNCNW7DLPXm2tj
	 H7Cxxics/ciy3y5vBLVO9UK6zXsLwgAyul0qLYcshS88VOeHMidq6IhuZLt6yKOoTAZ3t
	 O/71z/IUi69nCHhYduyhoT2ydumge2HU8zWMwPUwLUXrilfiP9klnuEczXzHOicq4Pj6J
	 isKIQPdBtXjb7sdpv+WirQLw8xV5q7vJTcG0xfOwsOakOSCISY70gQGRSHrZoG1gX51v3
	 2bowMkP4HUpe/HjeZQVe/GzI90GzUONXJLaw5aYz5ZvWRIke25jT+LJ/FOH2CuKBApA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906602;
	h=DMARC-Filter:DKIM-Signature:Date:Message-Id:X-Original-From:
	 Mime-Version:Received:Content-Transfer-Encoding:Cc:From:Subject:
	 Content-Type:References:To:X-Lms-Return-Path:In-Reply-To:X-Mailer;
	bh=Hx9ycWhbTIn7Xgvg5k3iHKhms/avTNC2TMXeb54Q1lE=;
	b=CzOV5qhpzJcNnB3d1xGgjj91e45AI2vbz/F5xvQ5qZ5PEl3O9n6IwHDBOJicyHXeQ6wK
	 CQeTHDd+2ej8CeaxY03Waieg+gqd4gMzzNOW/Wcj8VPh0LagpPC9eEtkjT8LBEGA+lSd2
	 u6mf3UWfoVT3T8A0S7TgiINMxqR0UVd0YuOHje9IktIjQ01yKFHL06/nvr8ueqIx0MOBd
	 4WAkdHv5Z47bB0E4PVI6e4cwxHrXTjOSFuL1SuQIeEtEvlONk7l62mRbwOh4n8TVEIflC
	 3thVUZhOMhXIZyU9og98By1fzpzX/sC9m0hpvMWrak4jUPBGplTqEWVc9z+fk25KJpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=jGs11Nw3;
	arc=none smtp.remote-ip=209.127.231.54
Received: from va-2-54.ptr.blmpb.com (va-2-54.ptr.blmpb.com [209.127.231.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E268606A334
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Nov 2026 09:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E268606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=jGs11Nw3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794906591;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Hx9ycWhbTIn7Xgvg5k3iHKhms/avTNC2TMXeb54Q1lE=;
 b=jGs11Nw3eJ1S7u9WnjMBZmmlQ29/7OC5OFX/a/xK53RPHKOe9Hp++LPh8BpAG+lVZnjTce
 h4bikYiSAyvyKi12ahHVzRV5HqSAoSiZBWNesXhAsSqJnqtITmSduRXkwccX1WHgm0czyd
 Rslpg39C4ZtMuGIoQ0LFJsNyGTEACi0uU7L1NMjevTVEdJisSnH+hPsz4e2EqMPG6QJuQt
 dfI0liHVqos2oLWRDsgKTjFtGKtuZuwRjdJHtIy3EuJbX8+fKW1MafneC6CWPpHfLFAx1t
 J/fgSWHd4i++fhYLHo9I6iQHDdBhOEkKSW6+Cfn+zY+iCvOmlAvF4bRJn98YpA==
Date: Tue, 17 Nov 2026 17:06:49 +0800
Message-Id: <20261117-mips-ls7a-wdt-v3-7-2e88f7e1d6c5@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Tue, 17 Nov 2026 17:09:48 +0800
Content-Transfer-Encoding: 7bit
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
From: "Rong Zhang" <rongrong@oss.cipunited.com>
Subject: [PATCH v3 7/7] MIPS: loongson3_defconfig: Enable LOONGSON1_WDT by default
Content-Type: text/plain; charset=UTF-8
References: <20261117-mips-ls7a-wdt-v3-0-2e88f7e1d6c5@oss.cipunited.com>
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
X-Lms-Return-Path: <lba+26afc19dd+9d2bd8+vger.kernel.org+rongrong@oss.cipunited.com>
In-Reply-To: <20261117-mips-ls7a-wdt-v3-0-2e88f7e1d6c5@oss.cipunited.com>
X-Mailer: b4 0.17-dev-ce4c1

The Loongson-7A has a watchdog compatible with the one on Loongson
2K0300. With the relevant node added to ls7a-pch.dtsi, enable
LOONGSON1_WDT in defconfig to make it work by default.

This basically mirrors commit 5e73ad3ffceb ("MIPS: Loongson1: Add
watchdog support for Loongson1 board") except that the driver is built
as a module, since some LOONGSON64 platforms are not LS7A-based.

The defconfig file is outdated, so this also refreshes it with
savedefconfig.

Tested on Loongson-LS3A4000-7A1000-NUC-SE and Lenovo KaiTian M530Z.

Signed-off-by: Rong Zhang <rongrong@oss.cipunited.com>
---
 arch/mips/configs/loongson3_defconfig | 54 ++++++-----------------------------
 1 file changed, 9 insertions(+), 45 deletions(-)

diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 12cb1a6a1360..00c591f21938 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -66,7 +66,6 @@ CONFIG_NF_CONNTRACK_SNMP=m
 CONFIG_NF_TABLES=m
 CONFIG_NFT_CT=m
 CONFIG_NFT_NAT=m
-CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
@@ -91,33 +90,11 @@ CONFIG_NF_TABLES_ARP=y
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
-CONFIG_IP_NF_MATCH_RPFILTER=m
 CONFIG_IP_NF_MATCH_TTL=m
-CONFIG_IP_NF_FILTER=m
-CONFIG_IP_NF_TARGET_REJECT=m
-CONFIG_IP_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
-CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_ECN=m
-CONFIG_IP_NF_TARGET_TTL=m
-CONFIG_IP_NF_RAW=m
-CONFIG_IP_NF_SECURITY=m
-CONFIG_IP_NF_ARPFILTER=m
-CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_TABLES_IPV6=y
 CONFIG_IP6_NF_IPTABLES=m
-CONFIG_IP6_NF_MATCH_RPFILTER=m
-CONFIG_IP6_NF_FILTER=m
-CONFIG_IP6_NF_TARGET_REJECT=m
-CONFIG_IP6_NF_MANGLE=m
-CONFIG_IP6_NF_RAW=m
-CONFIG_IP6_NF_SECURITY=m
-CONFIG_IP6_NF_NAT=m
-CONFIG_IP6_NF_TARGET_MASQUERADE=m
 CONFIG_NF_TABLES_BRIDGE=m
 CONFIG_BRIDGE_NF_EBTABLES=m
-CONFIG_BRIDGE_EBT_T_FILTER=m
-CONFIG_BRIDGE_EBT_T_NAT=m
 CONFIG_IP_SCTP=m
 CONFIG_L2TP=m
 CONFIG_BRIDGE=m
@@ -189,7 +166,6 @@ CONFIG_VIRTIO_NET=m
 # CONFIG_NET_VENDOR_ATHEROS is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_CHELSIO is not set
-# CONFIG_NET_VENDOR_CIRRUS is not set
 # CONFIG_NET_VENDOR_CISCO is not set
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
@@ -250,9 +226,9 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=16
 CONFIG_SERIAL_8250_EXTENDED=y
-CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_VIRTIO_CONSOLE=y
@@ -263,11 +239,14 @@ CONFIG_GPIO_LOONGSON=y
 CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM93=m
 CONFIG_SENSORS_W83627HF=m
+CONFIG_WATCHDOG=y
+CONFIG_WATCHDOG_NOWAYOUT=y
+CONFIG_WATCHDOG_SYSFS=y
+CONFIG_LOONGSON1_WDT=m
 CONFIG_MEDIA_SUPPORT=m
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_DRM=y
-CONFIG_DRM_RADEON=m
 CONFIG_DRM_AMDGPU=m
 CONFIG_DRM_AMDGPU_SI=y
 CONFIG_DRM_AMDGPU_CIK=y
@@ -276,6 +255,7 @@ CONFIG_DRM_AMD_ACP=y
 CONFIG_DRM_AMD_DC_SI=y
 CONFIG_DRM_AST=m
 CONFIG_DRM_QXL=y
+CONFIG_DRM_RADEON=m
 CONFIG_DRM_VIRTIO_GPU=y
 CONFIG_FB=y
 CONFIG_FB_RADEON=y
@@ -288,27 +268,12 @@ CONFIG_SND=m
 CONFIG_SND_SEQUENCER=m
 CONFIG_SND_SEQ_DUMMY=m
 # CONFIG_SND_ISA is not set
-CONFIG_SND_HDA_INTEL=m
 CONFIG_SND_HDA_PATCH_LOADER=y
-CONFIG_SND_HDA_CODEC_REALTEK=m
-CONFIG_SND_HDA_CODEC_REALTEK_LIB=m
-CONFIG_SND_HDA_CODEC_ALC260=m
-CONFIG_SND_HDA_CODEC_ALC262=m
-CONFIG_SND_HDA_CODEC_ALC268=m
-CONFIG_SND_HDA_CODEC_ALC269=m
-CONFIG_SND_HDA_CODEC_ALC662=m
-CONFIG_SND_HDA_CODEC_ALC680=m
-CONFIG_SND_HDA_CODEC_ALC861=m
-CONFIG_SND_HDA_CODEC_ALC861VD=m
-CONFIG_SND_HDA_CODEC_ALC880=m
-CONFIG_SND_HDA_CODEC_ALC882=m
+CONFIG_SND_HDA_INTEL=m
 CONFIG_SND_HDA_CODEC_SIGMATEL=m
-CONFIG_SND_HDA_CODEC_HDMI=m
-CONFIG_SND_HDA_CODEC_HDMI_GENERIC=m
-CONFIG_SND_HDA_CODEC_HDMI_INTEL=m
-CONFIG_SND_HDA_CODEC_HDMI_ATI=m
-CONFIG_SND_HDA_CODEC_HDMI_NVIDIA=m
 CONFIG_SND_HDA_CODEC_CONEXANT=m
+CONFIG_SND_HDA_CODEC_REALTEK=m
+CONFIG_SND_HDA_CODEC_HDMI=m
 # CONFIG_SND_USB is not set
 CONFIG_HIDRAW=y
 CONFIG_HID_A4TECH=m
@@ -406,7 +371,6 @@ CONFIG_PRINTK_TIME=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
-# CONFIG_SCHED_DEBUG is not set
 CONFIG_FUNCTION_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_CMDLINE_BOOL=y

-- 
2.55.0
