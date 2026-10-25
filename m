Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792956614;
	b=eAtctBVNBMnGEBxunN3/23088WptCLuSIdJ2KjKnRTQzvhL7LzlAJs8Ucgd0naydtLHa
	 ESJI1gIN44f9p/G3SMyaSuJ6dSsx9Y0KtjlSdXTBLO59XHqJ4zgzvt4dZD7ImTW1QL0io
	 LRUvH3agRFpJqzmZnKIcyFTZcnWl227ciK8eRQ9KoLtXILeQksVThLkg2fKiVCGjthH+z
	 2uMhCG/mN4dQdew63iQzWcCIAjXKfqTRQtLOabjxwZQRkdczH8A8YnxRNFf+O2NgEGX9M
	 Or8g1DSisW1BI3mb95QqBAroSD36EuFTXS2CVR5XXzhMbIR7HsBMVOYNyXElopc9GyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956614;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=id7QjALoxAPo7E4SdhvMjrZKW1hR51xHpAUwMdzan0k=;
	b=zuZ9VkE1fg1WH+Kip4IkMl71OjUczhg4gUGwn9SEz2IS5zDASCr2AXibUiF70P7GDBOL
	 ZLllN9ythBnz1ccqQlWb0atoHqQI0TI5lFpUv94Q3RFmH5GQTKIV+krLu+TIJi/MxTRia
	 ieliNoh6fhVHgtqXcMgVAuir7xi199+t54ksKeQzxGUE+NPWfVh4AwRLRn6sPZO5WS+iX
	 +shzsAmfGziav1Bf8Svg4HkthhMSnHdSk7TnLIjShNF7t3ZUjxXrcnlz/YXWudvinaLM6
	 yiODwq2XSERcVvTdNFvtw5AfS8+cFL83CJ7NKRIDkRvgjdcYu6vlnDW8O+jhJRov7yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=MDf5Gqgo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1D606A31E;
	Sun, 25 Oct 2026 19:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A1D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=MDf5Gqgo
ARC-Seal: i=1; a=rsa-sha256; t=1792956566; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=eMv/bAri8IF6pcaO2CYYPE5kK/AZFG5a/CSqDgLSsR2HWvYxk+yxYsd0tSrDMwb63v3rFOqplTdCdfemJwWohSOGYfUdV4tdhauhq6R63WcJ3NWhbNwK5oA1ORJg8WSxvYG00B8tQy1oJ1+U2YWuRzW+zE2h7kZIKkdd0hefcHA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1792956566; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=id7QjALoxAPo7E4SdhvMjrZKW1hR51xHpAUwMdzan0k=; 
	b=UxSkqiB5P2sq29YbmvMn/yKF4U8bc1imFTplIuYL/TQm8us6js/qzconkHtB2K72htyU8BugCRlThO4qcnXydCoAOhP0Adq5lNQepiIvZKOuezSsPPTAGZZvau8agJGrkXCFUaxJRBWT36lKGdMNjuJr6MjlvuETwok7B1KrMxo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792956566;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=id7QjALoxAPo7E4SdhvMjrZKW1hR51xHpAUwMdzan0k=;
	b=MDf5GqgoSZi4epNF+W+1G9CB/2NU2GRhy1bXA/pfTd425x+6ylNvFbJwETHz6F/O
	1ksD7ECZv5wJo9XMQeTVPDAYwiu8m08JtGMx242bX2mHWCt1kYd8vb8mHOJQ7D7eM2j
	3bGn2OdUiGjBggY4Hq1JGqvPZ7TRvewZaf1ukoUs=
Received: by smtp.zoho.eu with SMTPS id 1792956564711297.8298415361571;
	Sun, 25 Oct 2026 20:29:24 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, p.zabel@pengutronix.de, Sergey.Semin@baikalelectronics.ru, mika.westerberg@linux.intel.com, andi.shyti@kernel.org, Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH v4 2/2] watchdog: dw_wdt: manage reset line during system suspend/resume
Date: Sun, 25 Oct 2026 21:30:00 +0200
In-Reply-To: <CAOPX745u-2S4V_HfwPjkeiC+SLn6Z1GxQOTE3SqMFX75eZRKTw@mail.gmail.com>
References: <20261024140854.25664-1-a.shimko.dev@gmail.com> <20261024140854.25664-3-a.shimko.dev@gmail.com> <20261024-dw-wdt-shimko-v4-resume-imbalance@iav.lv> <CAOPX745u-2S4V_HfwPjkeiC+SLn6Z1GxQOTE3SqMFX75eZRKTw@mail.gmail.com>
Message-ID: <20261025-dw-wdt-shimko-v4-databook-ack@iav.lv>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Artem,

On Sun, Oct 25, 2026 at 09:32:44PM +0300, Artem Shimko wrote:
> The official datasheet DW_apb_wdt_databook says:
> The reset must be de-asserted synchronously after the rising edge of tclk.

Fair enough, the databook requirement wins; I withdraw the comment.
v4 is fine with me as is, and my Tested-by stands.

Thanks for checking,
Igor
