Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78D3A7F5D;
	Tue, 30 Jun 2026 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841997; cv=none; b=dQHdgtjpbo/cbvu17vT8qfGjp3pXIqQiX9aSR3aSWP66VnkS9jykFodZbjFYUAObp6pVLW+rwEs5m3uGebkicVA+n3HO9NQnlmiCVaNp2E/RngEOxohr1669ZZur58Sg1YJ02VmvCpIEP5QLEyA4a1tVlrJvB9OusL06/udXbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841997; c=relaxed/simple;
	bh=SuWU/DemszK/oLGWlCJ/Dp0AseJ85PCdrgIPDTnNegg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab7NZesK3Gn0C9jSSdmguMX36XKsXmlepyj/mSDvTPpy4c4vh3ftLI4Jzde0wMxnrpequIMOLm0gdis2WiE9LCV1wCnOP5Gy+IOivC0u7+aRbNOI9y0lNLUDjTO/7xBh027kxUI2eWVFhswpvxS4O1cCA0tapRjue8SOco4Qmgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGuXhfP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGuXhfP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC551F000E9;
	Tue, 30 Jun 2026 17:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782841995;
	bh=EDIm728+MZA+8oMM6niIdGNqoPV8BW9eVvdf71Q0sQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lGuXhfP3Yt4U7r05HOLf5FRtpaS1Mo7diQ+raRcott5k/oIlf2mQICiKQ0cwJIHZh
	 u0EiRv8VKXB8K091MTHbxctYsZekZJIpg7TlGBnz6R973tLxF19AGL7XyYCkpNEqw6
	 9L8rAj86j4kcgUVJlzsK63eM4UaYBF2UXR56GeK0TSjQVmhwJfcFhv0b7BUNDz6NKA
	 L301kknOolAVyMKcj0UcOyJul+K+xzRw9t5mqYw8mQJOhQTXkQLMjU8O1wEOQu+Vu3
	 rFcSgH6S1LNsMsKPG/QoV/vTkSQaLeJGR0uNswKIzCTx8KqZZ9TsZJkgPgxD7vRsCX
	 4GNfrrVqpxvyw==
Date: Tue, 30 Jun 2026 12:53:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, trilok.soni@oss.qualcomm.com,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, yijie.yang@oss.qualcomm.com,
	aiqun.yu@oss.qualcomm.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	tingwei.zhang@oss.qualcomm.com
Subject: Re: [PATCH v2] dt-bindings: watchdog: Document Qualcomm Maili
 watchdog
Message-ID: <178284199444.4137488.1292741710954214785.robh@kernel.org>
References: <20260629-maili-watchdog-v2-1-5cb9c83a581c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-maili-watchdog-v2-1-5cb9c83a581c@oss.qualcomm.com>


On Mon, 29 Jun 2026 00:09:05 -0700, Jingyi Wang wrote:
> Add devicetree binding for watchdog present on Qualcomm Maili SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
> Changes in v2:
> - patch resend
> - Link to v1: https://lore.kernel.org/r/20260524-maili-watchdog-v1-1-f7efef781701@oss.qualcomm.com
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

