Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66036CDF3;
	Thu, 13 Aug 2026 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608079; cv=none; b=OJBO/42I1UxR9qZszGX/c7dZf64mQDvKV0L/e7hE0PsNXQKGL+Es1vc/bYP9WOYLzx1smIOswOAmnStjuwBDHN6hVKvCgAGZsDmIZ1d4X4adwLAUXskT49asjc2FLGv6n0xnlZvX/fAsmB7dj5iNMClgAlp9qUoelA9uh82DNTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608079; c=relaxed/simple;
	bh=wyGhfMJWOy5UX7QC+Pb+5kG1q/ulVWJkK1naSkffHGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XesPS2YH9gT9Gwn/N/Hn/prLmsTmPaNkK0WZ1yayaiPMEjn3Mvra2AJ+TT1yVKnOp6ndy4AS0+OjNFFoxIPWptORIuEWmyaRV4ZLB0jugjn1VPmDvbsOW2iPmmGYkHnzuYkGZyzjYcSttVCmSoteMROqvfY5qx2QQLqQpJz4ZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gZPixR7t; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gZPixR7t"
X-UUID: 21ec387496ed11f18dc8c9802ae25ab1-20260813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wyGhfMJWOy5UX7QC+Pb+5kG1q/ulVWJkK1naSkffHGU=;
	b=gZPixR7tMVwDQg5pG18au1/tT7K4N214zMVKyGdcP0RVACEc1SFdHDK+gHhpvgmnboImwHRaSOYnBJa+PyLEmxbrciECw4IrwOgUC2vzbwV7XfyN57uj08vqC3UyO62o7LnCP0IhAGLWc+gVVazSvGd73sjxtUvpH4dR6vMDdJM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7d8b3995-e038-4327-9c26-bbeb98c11a8f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:084ad87e-ae59-454a-b730-9fc91b6907a6,B
	ulkID:nil,BulkQuantity:0,SF:81|82|83|102|836|865|888|898,TC:-5,Content:0|1
	5|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 21ec387496ed11f18dc8c9802ae25ab1-20260813
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ot_zexin.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 240204578; Thu, 13 Aug 2026 16:01:04 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 13 Aug 2026 16:01:03 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 13 Aug 2026 16:01:02 +0800
From: Zexin Wang <ot_zexin.wang@mediatek.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
	<linux@roeck-us.net>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <light.chen@mediatek.com>, <Fred-WY.Chen@mediatek.com>,
	<Yt.Hsieh@mediatek.com>, Zexin Wang <ot_zexin.wang@mediatek.com>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3] watchdog: sbsa_gwdt: add early_enable module parameter
Date: Thu, 13 Aug 2026 16:00:58 +0800
Message-ID: <20260813080102.2866-1-ot_zexin.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <27ebd686-c5de-4abf-9683-6a700b7592bc@roeck-us.net>
References: <27ebd686-c5de-4abf-9683-6a700b7592bc@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi Guenter,

Apologies for the quick turnaround on v3. I received an automated AI review
pointing out the documentation indentation issue and wanted to fix it
immediately, but I should have waited for your feedback first.

I've seen your comments on v3 (same as v2) and will address them properly
before sending the next version.

Thanks for your patience and guidance!

Best regards,
Zexin
