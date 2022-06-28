Return-Path: <linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55198CCA47E
	for <linux-watchdog@archiver.kernel.org>; Tue, 28 Jun 2022 20:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiF1UXY (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 28 Jun 2022 16:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiF1UVw (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Jun 2022 16:21:52 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBC99FEF
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jun 2022 13:19:42 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s124so18825998oia.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jun 2022 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kwf7QKhsDyHH90MDGkTbTlmNI8SrZ+37Blvr5GlXaPI=;
        b=y1cM8/IiHTTUC+Fc0bOyOhR+Jjg+mVNGNXSAOeAReF6523wvK8KjhIBlDcXP5aJHff
         VeNBfluxRO2oP2Xz59DdnmAQQvXHxCLkfrxWS6pChTYvW5+cZYJbrLPt++F92FZBBC/o
         4wfYALd7EVvHwQttxrPw53iOmC7mvM8Gv7KomT/WeX6xBdkt54+5zTQ2+q1hFMZBSmoB
         5PxoKXtqNh/M/KFlBABFuHZASpW/QSs1AyGEKEJfN6EyGtZIWQZh2WIA4DpEsq6mREG/
         420KYhE22vwRVU3bcFPyewysqFixPgovKtA0i2k0wMNF8FE6GliFO6HWTlqdbAA7ScgG
         iASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kwf7QKhsDyHH90MDGkTbTlmNI8SrZ+37Blvr5GlXaPI=;
        b=gtrNCyTBiyTYZkZp+TTxk/ct6P3qymDbOPZVwg0zPmv4C90heLxl5KcMDDwzVvTS5w
         5kbyKSxHmxi0zGRm+TMud8JAxoPiiWof3qzQe18sr9OoIIKC3iR0POPOD/CMiHBEnpl1
         XwRH37gzLPOyXxVBc5gSzadefIjT31CNjYCEkInGJGDlLlbpwkvIXkweSVGVt7Vr7xKf
         EK81P4qS3nUxsgX9oguWYG5JCAUBJxmJEtY/181Hphpj0zgFVwuyKWiJ/He59T0Ma5jr
         t0ARY0t/llkp+LvVvqql/YwFqnfVi1fM3OMdHrUcNrkvAXrGeZHeLTPmpkR+3T5Hj7s3
         H8Yg==
X-Gm-Message-State: AJIora8plvs4CNaJtds2zzVDjmDBIv4szJCufOeD+j7XuPx7d0hmcNpm
        kI6JbeBkpt7Fab9Ar7GM3kon6h8LzD0pyg==
X-Google-Smtp-Source: AGRyM1ufg+aVItdlpRKRIptLonzc3w8TpyCDvkMzHM6RwubyuYqC7WBFbuib8PL2IXZEi3f4mqPw7g==
X-Received: by 2002:a05:6808:612:b0:335:654c:1ebd with SMTP id y18-20020a056808061200b00335654c1ebdmr879609oih.211.1656447581856;
        Tue, 28 Jun 2022 13:19:41 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a12-20020a056870d60c00b000f30837129esm9536923oaq.55.2022.06.28.13.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:19:40 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     wim@linux-watchdog.org, Rohit Agarwal <quic_rohiagar@quicinc.com>,
        robh+dt@kernel.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: Re: (subset) [PATCH 04/11] dt-bindings: firmware: scm: Add compatible for SDX65
Date:   Tue, 28 Jun 2022 15:19:09 -0500
Message-Id: <165644753307.10525.13757217701045870006.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1654080312-5408-5-git-send-email-quic_rohiagar@quicinc.com>
References: <1654080312-5408-1-git-send-email-quic_rohiagar@quicinc.com> <1654080312-5408-5-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On Wed, 1 Jun 2022 16:15:05 +0530, Rohit Agarwal wrote:
> Add devicetree compatible for SCM present in SDX65 platform.
> 
> 

Applied, thanks!

[04/11] dt-bindings: firmware: scm: Add compatible for SDX65
        commit: 2ea6af6cc1f58f828180cf6124febbde47a10bad

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
