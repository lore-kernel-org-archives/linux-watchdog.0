Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54F1A681C;
	Sun, 23 Aug 2026 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503558; cv=none; b=Q6XFuhjeDrIk5Biztn6QzJDluqkH1x9B4K6i4wqv2afa+I7YfNFPZv5ytcV8PvCyZLqaXBoxLCJTbpsg9EY3Cm6hQNR6rasRaN5cbfQOZ3pW93Sy9fMQCXlFfcOYl+5wZfgmjQ4oKuyS99QLbvaeb+SLvqFDi+QTjAumdB306R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503558; c=relaxed/simple;
	bh=lWDBzGVeZ9KeiQa9XlsxvxbyVFOQ+dPhTC3FYp/FmL4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UExysWPR52HG6X4JIepL0fS2A50tP8HcApI+fzjpVmTIRCjGBNsYmQIN8+5P4UVgh+4WtktMUDfO11gijx8zBvu+aG6q0jGKq58uXJzeC3xzv3CEhzYekUHt9SjptEVB68f6fzFYxoMcdev9SrUfTv6IVKD8jpG7GDIdnVufFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=G+mlJ2/3; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G+mlJ2/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787503545; x=1788108345; i=markus.elfring@web.de;
	bh=lWDBzGVeZ9KeiQa9XlsxvxbyVFOQ+dPhTC3FYp/FmL4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=G+mlJ2/3vopchgYI6Lxss/lWpoumVdeDgDqp0WqXmPt0mnBYFBUTrxFqIj5mfGLW
	 RTsXwFrGjFfcLKUhpDBfAHmqLfNNINIXXLIojdXWT12LqmppprNF24NvXqmKKJhEm
	 daKOvZVtUvGOxIcTrOHK62CorkpruY6BdB4RitvIJNEloOeIC4T2v55smo6Mqd+6L
	 H51sJTp/L+8dUFUsoHWEpSVoKezd89b2eVx1aBkRE688LAdK2E8n6rH/DOgDLTr96
	 fxobM6BNUYs3fpyiUZ/k0Bea2+hSENFoSnu2jQRr/9Q2id5OPP+bwfucEA7aqmfJ2
	 aSAZ2T/LKHnsyHpnRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zs0-1wmJH31Hls-017kCC; Sun, 23
 Aug 2026 18:45:45 +0200
Message-ID: <7fc871a8-992a-470d-89ba-543a64c2cad2@web.de>
Date: Sun, 23 Aug 2026 18:45:41 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: manushprajwal555@gmail.com, linux-watchdog@vger.kernel.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Xingyu Wu <xingyu.wu@starfivetech.com>, Ziv Xu <ziv.xu@starfivetech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <6a8b157b.8e75e0cb.2cc15f.4aae@mx.google.com>
Subject: Re: [PATCH v2] watchdog: starfive: fix runtime PM usage counter leak
 in pm_start
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6a8b157b.8e75e0cb.2cc15f.4aae@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XnP3DXsMmL8YWN0Ta5IKdoO5elkV7/Ahfj8ZTlcdp5K5vhcMa6a
 R4SGgouVIyA7Snepl5eVsk9HGJT3CROb4JIV8iwuCBJTGrm9IPIXIwYptdkvH/GCuxK/5Ab
 xdq1GYrPNfr93dHScCVp55qwkeuHaYkqbsWLhaNswnEsHQ+ZuSRETK7mJNbjFBY3xPerExy
 I/3Vz4R/LFvhpb8GLlolw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WuTqQy/7W7M=;534XDkI92TPoWQcvgEn7Fjf/68s
 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
 /Nbf8J+NCmcKwUKX5Cok=

=E2=80=A6
> Fix it by calling pm_runtime_put_noidle() before returning, mirroring
> the same balance the counterpart starfive_wdt_pm_stop() already
> maintains with pm_runtime_put_sync().
=E2=80=A6

Can a bit of duplicate source code be avoided for the exception handling?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.2#n526

Regards,
Markus
