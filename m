Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460878;
	b=mMD2gHfHdfnMcWgOTz4PzfqTiqPr11du0ghL9InBgNXJwYdtY3tpBPpeu9JHlPx9cASk
	 nvFzzyq4ZIGOHO2QFHBDmsrI3E247vQp08HExYP2DasnSxXac2JG2BinK50/T7XBtuY+m
	 MJGL/FY+err+v7xWtk+Mky/FuBhoFV0R9eqforYC4fJnRj+2njR8R7YUzVNj7GadMusZU
	 OMb4g+67o/HEvTNe+640OH2ZCbKeKx1cOf0RlYWGEqTFVVRIPKZTNkc2Kw4/VzGQmSpU4
	 1RuVWL4TdWmljZiP5+x+yFHXs4N3VFazp/JXwZDBLPyMIuHV8/fdKPY7Di65XgVLhsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IQ/Tuyn0JH1gUFDpwUT2+qvwHnCZOxuYKusSWI+7qzw=;
	b=MxJWfJOOuxMABNGkvRO80QoaY4yt/1OUCiAU61tB+y8XLiqd4eJhcuS6D1D5rin09n2o
	 BpdaiEmXNfcERfVuWu/ktoDrFSNkWyleRl+EQjo1VtyIAcxaBiYD5brGChm9Eq0Sy9S7O
	 S27ZrumC9JGxfyYMSU0J23reUNTFVyd5HNHeoUtoqjr++I1xjoj3i3+2y7jwaoMM7NThI
	 Dx32EFHDeJ6gYbbxir/Am6aWBsGj3s5LYjgvjD5gdwY9VlYyZ7jqRd1z3fzhF5cFT2C9d
	 tNDyLAgJB4KNiB7BsQquiPGuPBzIX/I6htdZpBDCsC8ZgFyNTNIFBGQKDXUJfGLrR/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cTBtazj1;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F9606A319
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 375F9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cTBtazj1
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so6210091eec.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460877; x=1793065677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IQ/Tuyn0JH1gUFDpwUT2+qvwHnCZOxuYKusSWI+7qzw=;
        b=cTBtazj10dBdAIyArju2za5IXQxY+7ntjIgt/Hor5H90LKUi4pfWoyaCNHYX6Zhov3
         yh+8xoTVshkmGQRDLnNV30hn8iEF4WjYgqni+qs1zC2Emx4cylur9UA5xgWCeV+rxMdQ
         bKHRAl26Ro6pFvb0Dilz+VqfJALgeQKDRuqJf+5G3mhSIkMdyI+i+PmPUM2KRwB6hDWB
         4ASXJlOFH1bI4DOzuDDwClMrxPol9TX8W24KbFoIqCXhXmy95+P/2x1TdgEET6Ablrnr
         LUUWW4TuGRXRUTYvf1Y8BCpxQVtCThK+BylSPin8/C32+7cAVRJCJTJCMNY9p/YVjVTR
         v0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460877; x=1793065677;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IQ/Tuyn0JH1gUFDpwUT2+qvwHnCZOxuYKusSWI+7qzw=;
        b=LbMHDGX7uxRAB7cx0Aub7PlV9gjSzksxq490ThOImypCWF7rZJWZ1KuW6VqvhLeyeR
         pCUp31a8WtAHUBR984L3U5illPJUAc4LCKlbkws3kGG1+86onuOsmcRnAWRSdP6yG4KN
         nfYftluO8VB3Luq2d3jBcITu4SrlwQxyzgW+028yUem4VafOr7VlJN7KosgIpcv8pm80
         bNsB8m72TGk1+V5kygCfS0mQnPWqWjWQRR7/dGjugUL6j4dGemf8n3C9fWlPGTCIcBKj
         sHF5CHD/lzHuNtvYR6cVV6vYmusuuz1YrFo3XVsyybfzm2iyn//sQleUnANBPQPVkW0h
         86pA==
X-Forwarded-Encrypted: i=1; AKwUvBzcMWTMnttnHNPps0LbOn9dc8ICY0t+YiHTY9VW0XIgrlCIvGcK+TGK6nUSRke2HrV/GDhxqJD96riiunDXew==@vger.kernel.org
X-Gm-Message-State: AFq9FYJNzXyc1zo9iD8HlYVCtIe/lAIubSqRe6UKYkA60TvKwdkCk/8b
	LzaYDxj5hy5YsyG+nQk72gOQgfbYJbwRIAip4nBIEFHJIYZ3sk6RJfeK
X-Gm-Gg: AYBFou1JEuW8skEoqiQaK/P6Brsf00bpxUdyxheAB/OCB5bdpNGY8bMDuJQm9cShVt6
	lh+s+J/cetEwuqKeWPhh6jtmmTkh4P4bRXgxMR0iF1x4GefpIpoP6k8qExN9ACwwuoJMtzGtBHH
	C/ybPBe9eWbDuRIA63+nZISLcx+PK/kxUMF4X+eCuIABbsI4uxIySsJexHY2uQxxc9tlLc4Yqet
	PC478xGbqimR0V/9/uFwCX4R4Nlbt8xkGkCOifER2Xd2NgWrxx7en6dv8E37VLDJ5+2PJ8Hsohl
	8r26bw8jt9IjrX61P/3+W0h9DtYDMfYgK/ZmT4KiRMwnKEYCTXZbfN/2C8tes4mifdm0P/Hz8YC
	dIgInb8l3VNuk/8juT2KFJP6o8P62yziVoKrs9OjOCpmCVHpGJUzCRVDH6XsPpSjieMbBP96/3T
	baoU2c8a2+sArhnAg8SJ4BJdB7fnDumN9AlNkNF82t82givY7WldxlQgE8nxpkVFKY4opSJhhE0
	g/StOOYE0DlSQwHicytPzs=
X-Received: by 2002:a05:693c:83dc:10b0:362:fa87:2aa6 with SMTP id 5a478bee46e88-362fa872acemr10206165eec.0.1792460877332;
        Mon, 19 Oct 2026 18:47:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b792bsm37173189eec.5.2026.10.19.18.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:47:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:47:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chuanhong Guo <gch981213@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: reset: mediatek: add MT7629 TOPRGU
 reset indices
Message-ID: <6ffb487c-dd6c-4a6b-860b-f4e02d381cbb@roeck-us.net>
References: <20260926-b4-mt7629-toprgu-v1-0-c124bf9ac273@gmail.com>
 <20260926-b4-mt7629-toprgu-v1-1-c124bf9ac273@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926-b4-mt7629-toprgu-v1-1-c124bf9ac273@gmail.com>

On Sat, Sep 26, 2026 at 07:13:59PM +0800, Chuanhong Guo wrote:
> Define all seven reset IDs documented in the MT7629 TOPRGU SWSYSRST
> register: INFRA, ETHDMA, DDRPHY, INFRA_AO, CONN, APMIXED and CONN_MCU.
> Use their register bit positions as reset IDs.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
