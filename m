Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6758FD29
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986592; cv=none; b=WkGdOBOaM3NA3FC9wQwt6UIVdODNXlWOUtcGYpUgvPARJUPMrAk9DFMwgk9LyCQLkpKNQOe9DOWL+C2UgLZ1bfUV4OlKaAraXHWwLNFF65Ti8IYL51bk4vsuBpRsvoaGBPR7A3gCbCphIqK9GJuaHDZPSFYVeX5rR92G77Aax9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986592; c=relaxed/simple;
	bh=E7DWEF6kIazrc+lVVClekzdOah7P641Dc3PJ2nRN9Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djoI1habU7mJgYvA4fjbx4DrSBk+RogwhrutJmKoqHb5u4shPPN18mNVevhnDd9FUiPsTXhcjm53YEvfdXtHfN76zZbJB1U8vFowEhxe+Rn7ddljiGPwRTRvfI97W423+r6R//mOmFh2pcEoQSTVrIjP60KKLMpWNiPCJ6emgmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzutj+q1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzutj+q1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d715f4a587so87311015ad.2
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788986569; x=1789591369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WShcmBXFwgNzgoPR80LHtqAmSPW10etwWYZcOuhMszU=;
        b=bzutj+q1Fppr+Gt9UeN9vABv3gUmz1FwFsm//AkzqFB/cJoa5l/wuPpFwLHMwc+Wib
         nDgppEui6tU5k3BWZfuv60DElJ+ybZaXpmcQUV7Ja89RhWUqhFIBm9C5CPeFUPD/aTvh
         P+ocq3ccwaPJ77XXCx3Gwm74BHkgd+iQReOKa+5FOItmOE/WaOsRXLHyVy/C0yfmk5BM
         8yJEzdpi9Okz0ydZYilSs2cbv6Gnguaxw72tzxF48pcu/Chua1Cas4kqqjbSTzRLzjIq
         DmNUJmDrURL75lZA0VeWNmLmUWPAumCwZuslZjpTWgVmjlUNwt2axVVAO/ZQG9KFBseo
         NOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986569; x=1789591369;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WShcmBXFwgNzgoPR80LHtqAmSPW10etwWYZcOuhMszU=;
        b=K3shtJJvZJBQcXE21u+Es9XpBxDTCKFVtOJaXxbZuXb8YtNgPDkM+znqDShJ5BOHET
         hfxtQiXQuXMI11ISH32FCciMp1bPxIxFZ9H43cRvYolYA6SwDvr/xD/ACanLEaPTD8h0
         +3XR2M4gBah1r5SEeQv/hqXjWDHBJs05hp+7ykF/w+PGbFo1LSPUyzb33D+jRV2AWmnQ
         FFao3mRM/BpbrL2uvuT50b9eIwLae1wogj5TD/3MbMgxc1m23y8Rbmy1PMPdD3oPDQ2W
         Idi0PW7H3+8OGjOrJmvV2dMILXdV3YwWjEpOzSgXEx+Gav9wm7P92cKyuAQOPQRy5iSB
         Ofrw==
X-Forwarded-Encrypted: i=1; AKwUvByjj3ucNuFw3uCxb+yk+JcMf6TLsMMR/NdTlKyW+izKs97WS1WBBETQrYe/56E4fszNN6E8WvQ0vTtYytSOag==@vger.kernel.org
X-Gm-Message-State: AFuF++kaoLwh9wBxe+SJK2gPsAjyeqKr9jaRyKURJhGrfeL8gvov8WVh
	p1rWKlVdkWDAKuMMD436udhKj4VXAjmbkNmKTODO8tswBprdSCgWwdLm
X-Gm-Gg: AYBFou3UncLtGvtJJFHPsh5Fn6eVKhP2CR+B5iBjxviTi+Z+HK3UGqK4OnDmGTdecWD
	qC80yOYcTZlk3bLGnuzEenRDrvSwDgvg/j1Q4YB8UN/OyS+PrErGP8UWhm0o21d6hUz7VEOgZLq
	1ORYtIN1XIpcl3BG+GJ60w7PbGlf4mZLrQSgAoC5pRWb0boqFRFXCWWPOlutnNnZx5mYHW1r2sm
	Eto4HnVX+q0Mn1CzY+gkHpahVbXZP6bB+Hq39Svv/pX9xv4xMjuml6+blU7ILLRq9Y4mb+NANHH
	YCUR+x1YQpH5auPRHb5IZiCdGA99O8V2BSKHnfL4TkugCX9ne4kaKHKImQnuD0lAAcY6D8vcKg8
	RcT9yUo2FD0gtdw5c9bMxj9jHogBib/7xijU76+TkTfAltLIdHCred1TEMRyCxylwi+kHaLu6Go
	35JovPgjiuMxbqlS11YeVW0FEX3dcmn7N27kYQQNQswn9q1Tl/b+dFqXeHOcZ0X47ShVJmmJtvq
	glHr36UD+/4
X-Received: by 2002:a17:90b:2f46:b0:396:6344:3b63 with SMTP id 98e67ed59e1d1-39b260de5c6mr59642710a91.2.1788986569020;
        Wed, 09 Sep 2026 13:42:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d774197c4sm1220340a91.8.2026.09.09.13.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:42:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 13:42:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Zakariya Hadrami <zkh@mailbox.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, zkh1@proton.me,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: watchdog: mediatek: Add MT8127
Message-ID: <6a212071-3b1a-4dcd-8d9c-8df6352813b9@roeck-us.net>
References: <20260909-mt8127-amazon-ford-basic-v4-0-e9af5c420ab1@mailbox.org>
 <20260909-mt8127-amazon-ford-basic-v4-1-e9af5c420ab1@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-mt8127-amazon-ford-basic-v4-1-e9af5c420ab1@mailbox.org>

On Wed, Sep 09, 2026 at 09:38:00PM +0200, Zakariya Hadrami wrote:
> From: Zakariya Hadrami <zkh@mailbox.org>
> 
> Add entry for MT8127 SoC's watchdog which is compatible with MT6589's
> one.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Zakariya Hadrami <zkh@mailbox.org>

Applied.

Thanks,
Guenter
