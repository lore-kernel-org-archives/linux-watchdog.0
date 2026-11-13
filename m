Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567109;
	b=1jRYCP/404DcwcPFO5t4BqPUQOM2tt1+hlmSdF5Wdotqml0YnA5FDBcgY+fqWvJ767e2
	 0WpHginqpV1oo3crdq/VJm6yu0l+3wrqZgDDg7q5CS2uuySlE89ZfqLdhBvH/cdKJ5w3A
	 ljbWLrxC/dxzkIwekMKUmcU4H7i2JuWtnwvZ6fS3nBX4aeL3LqP59B16v7bpJw/kvoPFX
	 /mFacTzp6ocFYj0Di9sDbPzeTzlERLEWwO0eiXX0jTHZwIJsNBwO+9Ko78BguhgLpsLmx
	 7Kb6TSmgcjJrtnVj4VszgFM6JG/OZRr0yECDAvr0ag+oTJE+iMOSSS1XVDXslJardyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567109;
	h=DMARC-Filter:DKIM-Signature:From:References:X-Original-From:Subject:
	 Received:Content-Type:X-Mailer:Cc:Date:X-Lms-Return-Path:To:
	 Message-Id:Mime-Version:In-Reply-To:Content-Transfer-Encoding;
	bh=Hx9ycWhbTIn7Xgvg5k3iHKhms/avTNC2TMXeb54Q1lE=;
	b=jWLRoapB+gkSjo3EjXTa7Yqn4pqykOf13S94ELiy/w/eZCK0wybOijMiJFW3TJ37NPch
	 XO9DTtt3/au0oWXhmiMN28+BgggpiRVPAiyI3VfltundS76DX2o3NIDmiphAiEW1kY5iv
	 dX9WNzoucK2bzMwTrYbRjqqmZ8swLho4f1Ya+0UwI/3G71s4QJU00ruRbTkhN42aNgbrj
	 rnZUjimQvQJv9mbOo1wsHPDKcc+/oDGWlF6f3x2sH43zmsyyV0MxbPKgr26dmNIONKpji
	 o/5knkFdGWcrs/JVcTgl9Cr0Ewo5iCYq3VF5d9+IwvCS4eAXevGLKhCSj9xYycBn9kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cipunited.com;
	spf=pass smtp.mailfrom=oss.cipunited.com;
	dkim=pass header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=fz6tH35p;
	arc=none smtp.remote-ip=209.127.231.42
Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B9606A8AF
	for <linux-watchdog@vger.kernel.org>; Fri, 13 Nov 2026 10:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 011B9606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cipunited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cipunited.com header.i=@oss.cipunited.com header.a=rsa-sha256 header.s=feishu2303200042 header.b=fz6tH35p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303200042; d=oss.cipunited.com; t=1794567100;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Hx9ycWhbTIn7Xgvg5k3iHKhms/avTNC2TMXeb54Q1lE=;
 b=fz6tH35p4tNODfd3M7iYeRBi/bgqpbBclrsBV+hB/ngAH1JGgE3sbdwqDtYEB0GSfw0IRW
 JndzIPzaEyrN8S8OHiZdUlpf0QfhmFvkNCAUvhRUl7T8Vk0gOX6PPxj/gpqioIWB0zDvWU
 okE97fwjNgFceDgV4nV1qGXOuOW8LXJ2/GCoJAVur/7D4+biYRx/ylYdf4O23ysSdwStMc
 +MQiG4/FG6YqJmbiSIzqbtdF1gg4PrmQ6c26H3i6GP2w++MFfEu8jmGGTD4hRrtPA8LHzg
 IkEvDWblCkR1yC7kuVh+Plwkx5B4ylsWhTO9SBN4aID/MgVU88t1oLaIzkAXQQ==
From: "Rong Zhang" <rongrong@oss.cipunited.com>
References: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
X-Original-From: Rong Zhang <rongrong@oss.cipunited.com>
Subject: [PATCH v2 8/8] MIPS: loongson3_defconfig: Enable LOONGSON1_WDT by default
Received: from [127.0.1.1] ([171.15.157.139]) by smtp.feishu.cn with ESMTPS; Fri, 13 Nov 2026 18:51:35 +0800
Content-Type: text/plain; charset=UTF-8
X-Mailer: b4 0.17-dev-ce4c1
Cc: "Rong Zhang" <i@rong.moe>, "Yao Zi" <me@ziyao.cc>, 
	"Icenowy Zheng" <uwu@icenowy.me>, 
	"Jiaxun Yang" <jiaxun.yang@flygoat.com>, <linux-mips@vger.kernel.org>, 
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	"Rong Zhang" <rongrong@oss.cipunited.com>
Date: Fri, 13 Nov 2026 18:51:15 +0800
X-Lms-Return-Path: <lba+26af6ebba+4e4860+vger.kernel.org+rongrong@oss.cipunited.com>
To: "Keguang Zhang" <keguang.zhang@gmail.com>, 
	"Wim Van Sebroeck" <wim@linux-watchdog.org>, 
	"Guenter Roeck" <linux@roeck-us.net>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, 
	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Message-Id: <20261113-mips-ls7a-wdt-v2-8-e8abd6b2f77c@oss.cipunited.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
In-Reply-To: <20261113-mips-ls7a-wdt-v2-0-e8abd6b2f77c@oss.cipunited.com>
Content-Transfer-Encoding: 7bit

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
